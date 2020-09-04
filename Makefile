IMAGE := alpine/fio
APP:="scripts/archlinux-req.sh"

deploy-zabbix:
	bash scripts/deploy-zabbix.sh

deploy-libvirt:
	bash scripts/deploy-libvirt.sh

deploy-vagrant:
	bash scripts/deploy-vagrant.sh

push-image:
	docker push $(IMAGE)

.PHONY: deploy-vagrant deploy-libvirt deploy-zabbix push-image
