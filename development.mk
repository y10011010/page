CONTAINER = page
TAG       = latest
git_user  = $(ID)
git_email = $(ID)@rd.org
WORKDIR   = $(shell pwd)
KEYS      = $(WORKDIR)/$(git_user)/gnupg
ADDRESS   = $(WORKDIR)/$(git_user)/address
PASSWORDS = $(WORKDIR)/$(git_user)/passwords
