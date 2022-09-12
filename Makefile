USERPASS := `cat .rokulogin`
ROKU_DEV_TARGET := 192.168.86.31

RunningStreamYourChannel.zip: components/*.xml source/*.brs images/* manifest
	zip -r $@.tmp * -x Makefile $@ packages/* packages
	mv $@.tmp $@

# Sometimes it needs to be mysubmit=replace, sometimes Install
remove: 
	touch .empty
	curl --user $(USERPASS) --digest  --show-error \
        -F "archive=@.empty;type=application/octet-stream" -F "mysubmit=Delete" \
        --output tempfile \
        --write-out "%{http_code}" \
        http://$(ROKU_DEV_TARGET)/plugin_install

install: RunningStreamYourChannel.zip
	echo "Do telnet $(ROKU_DEV_TARGET) 8085"
	curl --user $(USERPASS) --digest  --show-error \
        -F "mysubmit=Install" -F "archive=@$<;type=application/zip" -F "mysubmit=Install" \
        --output tempfile \
        --write-out "%{http_code}" \
        --max-time 2 \
        http://$(ROKU_DEV_TARGET)/plugin_install

replace: RunningStreamYourChannel.zip
	echo "Do telnet $(ROKU_DEV_TARGET) 8085"
	curl --user $(USERPASS) --digest  --show-error \
        -F "mysubmit=replace" -F "archive=@$<;type=application/zip" -F "mysubmit=replace" \
        --output tempfile \
        --write-out "%{http_code}" \
        --max-time 2 \
        http://$(ROKU_DEV_TARGET)/plugin_install
