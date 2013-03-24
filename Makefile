.PHONY: output init template css build

# setup path
app_path:="app"
output_path:="output"

# Using time as file name
filetime:=$(shell date '+%Y%m%d%H%M%S')
file_list:=$(find assets/templates/ -name "*.handlebars")

all: init
	r.js -o build/self.build.js

init:
	@which bower 1> /dev/null 2>&1 ; if [ $$? -ne 0 ] ; then ./build/build.sh ; fi
	@test -d "$(app_path)/assets/vendor" || bower install
	@echo "Install bower package compeletely."
	@npm install

template:
	mkdir "$(app_path)/assets/tmp"
	for file in `find $(app_path)/assets/templates/ -type f -name '*.handlebars'`; \
	do \
		name=`basename $$file`; \
		java -jar build/htmlcompressor-1.5.3.jar --remove-intertag-spaces --compress-js -o $(app_path)/assets/tmp/$$name $$file; \
	done
	handlebars $(app_path)/assets/tmp/*.handlebars -m -f $(app_path)/assets/templates/template.js -k each -k if -k unless
	rm -rf "$(app_path)/assets/tmp"

css:
	for file in `find $(output_path)/assets/css/ -type f -name '*.css'`; \
	do \
		sqwish $$file -o $$file; \
	done

build: all
	rm -rf $(output_path)
	r.js -o build/app.build.js

output: template build css
	rm -rf $(output_path)/assets/js/*
	cp -r $(output_path)/assets/vendor/requirejs/require.js $(output_path)/assets/js/
	cp -r $(app_path)/assets/js/main-built.js $(output_path)/assets/js/$(filetime).js
	rm -rf $(output_path)/build.txt
	rm -rf $(output_path)/assets/coffeescript $(output_path)/assets/sass $(output_path)/assets/config.rb
	rm -rf $(output_path)/assets/vendor $(output_path)/assets/templates
	sed -i 's/js\/main/js\/$(filetime)/g' $(output_path)/index.html
	sed -i 's/vendor\/requirejs\//js\//g' $(output_path)/index.html
	-java -jar build/htmlcompressor-1.5.3.jar --remove-intertag-spaces --compress-js -o $(output_path)/index.html $(output_path)/index.html
	@echo
	@echo "======================================================="
	@echo "=> Install compeletely."
	@echo "=> Please copy output folder to your web root path."
	@echo "======================================================="
	@echo

clean:
	rm -rf output
	rm -rf node_modules
	rm -rf $(app_path)/assets/vendor
	rm -rf $(app_path)/assets/tmp
	rm -rf $(app_path)/assets/templates/template.js
	rm -rf $(app_path)/assets/js/main-built.js
	rm -rf $(app_path)/assets/js/main-built.js.map
	rm -rf $(app_path)/assets/js/main-built.js.src
