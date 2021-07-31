USERPASS := `cat .rokulogin`
ROKU_DEV_TARGET := 192.168.7.181

RunningStreamYourChannel.zip: components/*.xml source/*.brs images/*
	zip -r $@ * -x Makefile

install: RunningStreamYourChannel.zip
	echo "Do telnet $(ROKU_DEV_TARGET) 8085"
	curl --user $(USERPASS) --digest --silent --show-error \
        -F "mysubmit=Install" -F "archive=@$<" \
        --output tempfile \
        --write-out "%{http_code}" \
        http://$(ROKU_DEV_TARGET)/plugin_install
