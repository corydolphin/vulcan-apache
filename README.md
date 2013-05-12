Vulcan Apache: Vendoring Apache for Heroku
=================================

This is an example of [vendoring binaries](https://devcenter.heroku.com/articles/buildpack-binaries) for usage on Heroku, using Vulcan as a build tool. In this case, we compile Apache httpd-2.4.4 from source, and build the required dependencies.

While Heroku's documentation shows that you can inline commands for vulcan to use to build, I found it far more useful to
have vulcan execute a shell script to actually build the application and its dependencies (`build.sh`).


## Usage

In order to build this project using Vulcan:

Install Vulcan with

    $ gem install vulcan

Create a Vulcan build server:

    $ vulcan create vulcan-wcdolphin
    Creating vulcan-wcdolphin... done, stack is cedar
    http://vulcan-wcdolphin.herokuapp.com/ | git@heroku.com:vulcan-wcdolphin.git    

Build httpd using the build script, which simply builds PCRE, and then httpd:

    $ vulcan build -v -c "sh build.sh"
    >> Messy build spew omitted
    >> Downloading build artifacts to: /tmp/apache-bench.tgz

The resultant .tgz file can easily be included in a Heroku application by using [heroku-buildpack-vendor-binaries](https://github.com/wcdolphin/heroku-buildpack-vendorbinaries) and the [Heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi). Include a link to the apache-bench.tgz file, hosted on S3 or even Dropbox, in the .vendor_urls file.
Ensure that you have added the httpd libs directory to your Heroku apps' `LD_LIBRARYT_PATH` environmental variable, by running
    
    $ heroku config:add LD_LIBRARY_PATH=/app/vendor/apache-2.4.4/lib/:$LD_LIBRARY_PATH


## Details

The `-v` flag enables verbose mode for debugging, while the `-c` flag specifies a command for vulcan.

As Heroku does not have any of the required libraries for Apache httpd, we include the dependencies following [Apache's documentation](http://httpd.apache.org/docs/2.2/install.html), we use the `--with-apr-included` flag, after extraction apr and apr-util to the `httpd-2.4.4/srclib` directory.

