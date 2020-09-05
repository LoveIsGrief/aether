#!/bin/bash

buildClient() {
    echo "Building client"
    CLIENT="../aether-core/aether/client"

    # TODO: --npm-sources
    if [[ -n "$OPT_NPM_SOURCES" ]] ; then (
	echo "Generate npm sources"
	GENERATOR="$(pwd)/flatpak-builder-tools/node/flatpak-node-generator.py"
        cd "$CLIENT"
	# Need this because flatpak has no network connection
	# So we need to tell npm where to get all the files from
	python3 $GENERATOR --no-devel npm package-lock.json
    ) fi

    echo "Building ..."
    flatpak-builder --force-clean build-dir net.nehbit.AetherClient.yml
}

printHelp(){
    echo "build.sh
    Requirements:
      flatpak-builder
      python3.6+
    "
}

case $1 in

    client)
	shift
	buildClient "$@"
    ;;

    *) 
	printHelp
	;;

esac
