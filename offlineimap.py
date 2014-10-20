#!/usr/bin/python
from ConfigParser import ConfigParser
import os 

defaults = {}

def parse_config():
    cfg = ConfigParser(defaults)
    cfg.read(os.path.join(os.getenv("HOME"), "dotfiles/offlineimap.ini"))
    return cfg

def get_email(account):
    cfg = parse_config()
    return cfg.get("email_addresses", account)
    
def get_password(account):
    cfg = parse_config()
    return cfg.get("pass_mail", account)
