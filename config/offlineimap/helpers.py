#!/usr/bin/python
import os, re, subprocess

# Get a password out of the system keychain
def get_keychain_pass(account=None, server=None):
    params = {
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'server': server,
        'keychain': os.environ['HOME'] + '/Library/Keychains/login.keychain',
    }
    command = "sudo -u " + os.environ['USER'] + " %(security)s -v %(command)s -g -a %(account)s -s %(server)s %(keychain)s" % params
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    outtext = [l for l in output.splitlines()
               if l.startswith('password: ')][0]

    return re.match(r'password: "(.*)"', outtext).group(1)

def get_access_token(account=None):
    return bytearray(get_keychain_pass(account, "oauth2-access.gmail.com"))

def get_client_id(account=None):
    return get_keychain_pass(account, "oauth2-client.gmail.com")

def get_client_secret(account=None):
    return get_keychain_pass(account, "oauth2-secret.gmail.com")

def get_refresh_token(account=None):
    return bytearray(get_keychain_pass(account, "oauth2-refresh.gmail.com"))

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
      return prefix + folder.capitalize()

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

def should_sync_siberia(folder):
    return not folder == '[Gmail]/Spam' \
        and not folder == '[Gmail]/Important' \
        and not folder == '[Gmail]/Starred' \
        and not folder == '[Gmail]/Trash' \
        and not folder.startswith('[Readdle]') \
        and not folder.startswith('avis') \
        and not folder.startswith('billing') \
        and not folder.startswith('cloudnav') \
        and not folder.startswith('contacts') \
        and not folder.startswith('dated') \
        and not folder.startswith('intel') \
        and not is_airmail_folder(folder)

def should_sync_fastmail(folder):
    return not folder == 'INBOX.Junk Mail' \
        and not folder == 'INBOX.Notes' \
        and not folder == 'INBOX.Trash' \
        and not folder.endswith('taxes-2014') \
        and not folder.endswith('taxes-2015') \
        and not folder.endswith('taxes-2016') \
        and not folder.endswith('taxes-2017') \
        and not is_airmail_folder(folder)

# Checks if the name of folder is one commonly used by Airmail
def is_airmail_folder(folder):
    return folder.startswith('[Airmail]')

# Offlineimap methods for fastmail.fm accounts
def fastmail_remote(folder):
    return remote_lowered(folder)

def fastmail_local(folder):
    mapping = {
        'junk':      'INBOX.Junk Mail',
        'sent':      'INBOX.Sent Items',
    }
    return local_capitalized(folder, mapping, 'INBOX.')

# Offlineimap methods for lynr.co accounts
# Uses `remote_lowered` but the remote mailboxes aren't preceded by 'INBOX.'
# so the translations only splits and lowercases.
def lynrco_remote(folder):
    return fastmail_remote(folder)

def lynrco_local(folder):
    return fastmail_local(folder)

