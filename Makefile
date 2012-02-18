
build:
	@find lib -name '*.coffee' | xargs coffee -c 

clean:
	@find lib -name '*.coffee' | sed 's,coffee$$,js,' | xargs rm -f

