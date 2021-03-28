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

run: prepare
	docker run \
		--rm -it \
		-v $(WORKDIR):/work \
		-v $(KEYS):$(VOLUME_GPG) \
		-v $(ADDRESS):$(VOLUME_ABOOK) \
		-v $(PASSWORDS):$(VOLUME_PASS) \
		$(CONTAINER):$(TAG) $(COMMAND)

build:
	docker build --build-arg git_user=$(git_user) --build-arg git_email=$(git_email) -t $(CONTAINER):$(TAG) .

%.pkr.hcl:
	packer build $@

.PHONY: $(KEYS) $(ADDRESS) $(PASSWORDS)
prepare: $(KEYS) $(ADDRESS) $(PASSWORDS)
	for item in $?; do mkdir -p $$item; done

