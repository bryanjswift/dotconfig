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
def local_capitalized(folder, mapping={}):
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

# Offlineimap methods for fastmail.fm accounts
def fastmail_remote(folder):
    return remote_lowered(folder)

def fastmail_local(folder):
    mapping = {
        'archive':   'INBOX.Archive',
        'drafts':    'INBOX.Drafts',
        'junk':      'INBOX.Junk Mail',
        'sent':      'INBOX.Sent Items',
        'trash':     'INBOX.Trash',
    }
    return mapping.get(folder, folder)

# Offlineimap methods for lynr.co accounts
# Uses `remote_lowered` but the remote mailboxes aren't preceded by 'INBOX.'
# so the translations only splits and lowercases.
def lynrco_remote(folder):
    return remote_lowered(folder)

def lynrco_local(folder):
    mapping = { 'sent': 'Sent Messages', }
    return local_capitalized(folder, mapping)

