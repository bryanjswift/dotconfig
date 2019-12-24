#!/usr/bin/python
import os, re, subprocess, sys

# Requires a signed in 1password account and the 1password command line tool
# See https://support.1password.com/command-line/
#
# **Params**
# * `account` - matches the title of the 1password item
# * `server` - matches the url of the 1password item
#
# **Returns** the UUID of the 1password item
#
def get_1password_uuid(account=None, server=None):
    params = {
        'account': account,
        'server': server,
    }
    command = "op list items --vault=offlineimap | jq -r '.[] | select(.overview.url == \"%(server)s\" and .overview.title == \"%(account)s\").uuid'" % params
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    return output.splitlines()[0]

# Requires a signed in 1password account and the 1password command line tool
# See https://support.1password.com/command-line/
#
# **Params**
# `account` - matches the title of the 1password item
# `server` - matches the url of the 1password item
#
# **Returns** the pasword value associated with the `account` and `server`.
#
def get_1password_pass(account=None, server=None):
    params = {
        'uuid': get_1password_uuid(account, server),
    }
    uuid = get_1password_uuid(account, server)
    command = "op get item --vault=offlineimap --fields=password %(uuid)s" % params
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    return output.splitlines()[0]

def get_access_token(account=None):
    return bytearray(get_1password_pass(account, "https://oauth2-access.gmail.com"))

def get_client_id(account=None):
    return get_1password_pass(account, "https://oauth2-client.gmail.com")

def get_client_secret(account=None):
    return get_1password_pass(account, "https://oauth2-secret.gmail.com")

def get_refresh_token(account=None):
    return bytearray(get_1password_pass(account, "https://oauth2-refresh.gmail.com"))

# Take a folder name that is not 'INBOX' then:
# 1. remove prefixed 'INBOX.'
# 1. make it lowercase
# 1. split lowercased on ' '
# 1. return the first part of the split
def remote_lowered(folder):
    if folder == 'INBOX':
        return folder
    else:
        return folder.replace('INBOX.', '').lower().split(' ')[0]

# Take a folder name that is not 'INBOX' then:
# If folder in mapping.keys() return the corresponding value
# If folder not in mapping.keys() return folder with the first letter capitalized
def local_capitalized(folder, mapping={}, prefix=''):
    if folder == 'INBOX':
        return folder
    elif folder in mapping.keys():
        return mapping.get(folder)
    else:
        return folder.capitalize()

# Provide a mapping of common [Gmail] folders
def gmail_mapping():
    return {
        '[Gmail]/All Mail':   'archive',
        '[Gmail]/Drafts':     'drafts',
        '[Gmail]/Important':  'important',
        '[Gmail]/Sent Mail':  'sent',
        '[Gmail]/Starred':    'starred',
        '[Gmail]/Trash':      'trash',
        '[Gmail]/Spam':       'junk',
    }

# Offlineimap nametrans methods for gmail accounts
def gmail_remote(folder):
    mapping = gmail_mapping()
    return mapping.get(folder, folder)

def gmail_local(folder):
    m = gmail_mapping()
    mapping = dict(zip(m.values(), m.keys()))
    return mapping.get(folder, folder)

# Checks if the name of folder is one commonly used by Airmail
def is_airmail_folder(folder):
    return folder.startswith('[Airmail]')

# Checks if the name of folder is 'All'
def is_protonmail_all_folder(folder):
    return folder.endswith('All Mail')

# Offlineimap methods for fastmail.fm accounts
def fastmail_remote(folder):
    return remote_lowered(folder)

def fastmail_local(folder):
    mapping = {
        'junk':      'Junk Mail',
        'sent':      'Sent Items',
    }
    return local_capitalized(folder, mapping, 'INBOX.')

# Offlineimap methods for protonmail accounts
def protonmail_mapping():
    return {
        'All Mail': 'all',
        'Archive': 'archive',
        'Sent': 'sent',
        'Spam': 'spam',
        'Trash': 'trash',
    }

def protonmail_remote(folder):
    mapping = protonmail_mapping()
    return mapping.get(folder, folder)

def protonmail_local(folder):
    m = protonmail_mapping()
    mapping = dict(zip(m.values(), m.keys()))
    return mapping.get(folder, folder)

# Offlineimap methods for lynr.co accounts
# Uses `remote_lowered` but the remote mailboxes aren't preceded by 'INBOX.'
# so the translations only splits and lowercases.
def lynrco_remote(folder):
    return fastmail_remote(folder)

def lynrco_local(folder):
    return fastmail_local(folder)

# Define wrapper function for whether or not a fastmail folder should sync
def should_sync_fastmail(folder):
    return not folder == 'INBOX.Junk Mail' \
        and not folder == 'INBOX.Notes' \
        and not folder == 'INBOX.Trash' \
        and not folder.endswith('taxes-2014') \
        and not folder.endswith('taxes-2015') \
        and not folder.endswith('taxes-2016') \
        and not folder.endswith('taxes-2017') \
        and not is_airmail_folder(folder)

# Define wrapper function for whether or not a siberia folder should sync
def should_sync_gmail(folder):
    return not folder == '[Gmail]/Spam' \
        and not folder == '[Gmail]/Important' \
        and not folder == '[Gmail]/Trash' \
        and not folder.startswith('freelance') \
        and not folder.startswith('lynr') \
        and not folder.startswith('persnicketly') \
        and not folder.startswith('recipes') \
        and not folder.startswith('taxes') \
        and not is_airmail_folder(folder)

# Define wrapper function for whether or not a siberia folder should sync
def should_sync_siberia(folder):
    return not folder == '[Gmail]/Spam' \
        and not folder == '[Gmail]/Important' \
        and not folder == '[Gmail]/Trash' \
        and not folder.startswith('[Readdle]') \
        and not folder.startswith('avis') \
        and not folder.startswith('billing') \
        and not folder.startswith('cloudnav') \
        and not folder.startswith('contacts') \
        and not folder.startswith('dated') \
        and not folder.startswith('intel') \
        and not is_airmail_folder(folder)

def main(account=None, server=None):
    if account == None:
        print 'Account must be provided to retrieve password.'
        sys.exit(1)
    elif server == None:
        print 'Server must be provided to retrieve password.'
        sys.exit(1)
    else:
        print get_1password_pass(account, server)

if __name__ == "__main__":
    main(account=sys.argv[1], server=sys.argv[2])
