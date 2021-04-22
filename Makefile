# Use case
# ---
#
# Export a secret key:
#
# $ make run -e KEYS=/path/to/keys
#
# From within the running container
#
# $ gpg --export-secret-key --armour my@key.net > /work/key.asc

ID = white
APPLICATION_ENVIRONMENT ?= development
include $(APPLICATION_ENVIRONMENT).mk


VOLUME_PASS = /root/.password-store
VOLUME_GPG = /root/.gnupg
VOLUME_ABOOK = /root/.abook

/Volumes/workspace/.latest:
	restic -r $(RESTIC_REPOSITORY) --password-command="$(RESTIC_PASSWORD_COMMAND)" --json snapshots | jq -r .[-1].short_id > $@

restore:
	restic -r $(RESTIC_REPOSITORY) --password-command="$(RESTIC_PASSWORD_COMMAND)" \
		--json snapshots | jq -r .[-1].short_id > $@

run: prepare
	# pushd $(WORKDIR)
	# restic -r $(RESTIC_REPOSITORY) --password-command=$(RESTIC_PASSWORD_COMMAND) restore 46dc561a --target .
	docker run \
		--rm -it \
		-v $(WORKDIR):/work \
		-v $(KEYS):$(VOLUME_GPG) \
		-v $(ADDRESS):$(VOLUME_ABOOK) \
		-v $(PASSWORDS):$(VOLUME_PASS) \
		-v $(RESTIC_REPOSITORY):$(RESTIC_REPOSITORY) \
		$(CONTAINER):$(TAG) $(COMMAND)
	${MAKE} clean

clean:
	echo "\n FIXME..."
	echo "\n Cleaning up..."
	# cd $(WORKDIR); rm -rf *.jpg; rm -rf key.*
	# RESTIC_REPOSITORY=$(RESTIC_REPOSITORY) RESTIC_PASSWORD_COMMAND=$(RESTIC_PASSWORD_COMMAND) ID=$(ID) ./create-snapshot.sh
	diskutil eraseVolume APFS workspace $(WORKDIR)


build:
	docker build \
		--build-arg git_user=$(git_user) \
		--build-arg git_email=$(git_email) \
		--build-arg passphrase=$(passphrase) \
		--build-arg restic_repository=$(RESTIC_REPOSITORY) \
		--build-arg restic_password_command=$(RESTIC_PASSWORD_COMMAND) \
		-t $(CONTAINER):$(TAG) .

.password-store/$(ORG)/$(ID):
	pass generate -n white@rand.org

%.pkr.hcl:
	packer build $@

.PHONY: $(KEYS) $(ADDRESS) $(PASSWORDS)
prepare: $(KEYS) $(ADDRESS) $(PASSWORDS)
	for item in $?; do mkdir -p $$item; done
	cp start $(WORKDIR)/
	cp key.stat $(WORKDIR)/
	cp key.dyno $(WORKDIR)/
	cp infile $(WORKDIR)/

