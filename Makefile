include defines.make

build_base:
	@docker build . --target build_base --build-arg TOMCAT_MAJOR_VERSION --build-arg TOMCAT_VERSION --build-arg FROM_IMAGE  -t centos7/lamp:build_base --file dockerfiles/Dockerfile.centos

# build_env:
# 	@docker build . --target build_env -t centos7/tomcat:build_env --file dockerfiles/Dockerfile.tomcat.multi
#
# build_openjdk11:
# 	@docker build . --target build_openjdk11 -t centos7/tomcat:build_openjdk11 --file dockerfiles/Dockerfile.tomcat.multi
#
# build_tomcat9030:
# 	@docker build . --target build_tomcat9030_openjdk11 -t centos7/tomcat:build_tomcat9030_openjdk11 --file dockerfiles/Dockerfile.tomcat.multi
#
# config_admin:
# 	@docker build . --target config_admin -t centos7/tomcat:config_admin --file dockerfiles/Dockerfile.tomcat.multi
#
# deploy_sampleapp:
# 	@docker build . --target deploy_sampleapp -t centos7/tomcat:deploy_sampleapp --file dockerfiles/Dockerfile.tomcat.multi
#
# build_finalize:
# 	@docker build . --target build_finalize -t centos7/tomcat:sampleapp-openjdk11-tomcat9030-centos7 --file dockerfiles/Dockerfile.tomcat.multi
#
# run_sampleapp:
# 		@sudo docker container run -it -d --name sampleapp -p 8080:8080 -p 8009:8009 centos7/tomcat:sampleapp-openjdk11-tomcat9030-centos7

clean:
	@docker rmi $(docker images -q -f dangling=true)

# build_all:
# 	@docker build . --target build_base -t centos7/tomcat:build_base --file dockerfiles/Dockerfile.tomcat.multi
# 	@docker build . --target build_env -t centos7/tomcat:build_env --file dockerfiles/Dockerfile.tomcat.multi
# 	@docker build . --target build_openjdk11 -t centos7/tomcat:build_openjdk11 --file dockerfiles/Dockerfile.tomcat.multi
# 	@docker build . --target build_tomcat9030_openjdk11 -t centos7/tomcat:build_tomcat9030_openjdk11 --file dockerfiles/Dockerfile.tomcat.multi
# 	@docker build . --target config_admin -t centos7/tomcat:config_admin --file dockerfiles/Dockerfile.tomcat.multi
# 	@docker build . --target deploy_sampleapp -t centos7/tomcat:deploy_sampleapp --file dockerfiles/Dockerfile.tomcat.multi
# 	@docker build . --target build_finalize -t centos7/tomcat:sampleapp-openjdk11-tomcat9030-centos7 --file dockerfiles/Dockerfile.tomcat.multi
