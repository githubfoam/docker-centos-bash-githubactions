IMAGE := alpine/fio
APP:="scripts/usernetes-containerd.sh"

deploy-manual-build:
	bash scripts/deploy-manual-build.sh
deploy-manual-build-apache:
	bash scripts/deploy-manual-build-apache.sh	
deploy-manual-build-apache-podman:
	bash scripts/deploy-manual-build-apache-podman.sh		
push-image:
	docker push $(IMAGE)

.PHONY: deploy-libvirt deploy-vagrant deploy-packer deploy-terraform push-image
