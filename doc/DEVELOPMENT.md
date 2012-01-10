# Developer information

This is a Rails 3.1.1 Application

## Install Bookcamping in your computer as a development server

Bookcamping REQUIRES mysql and git installed on your computer (on ubuntu use apt-get)
Also requires ruby version 1.9.2 (soon it will be changed to 1.9.3)

To install ruby the recommended way is using RVM. So you need to install rvm (http://beginrescueend.com/rvm/install/) 
and then use RVM to install ruby 1.9.2 
{{{
rvm install 1.9.2
rvm --default 1.9.2
}}}

You have to clone the code using git:
{{{
git clone <the_url_github_provides>
}}}

And then create a ruby environment using rvm:
{{{
cd Bookcamping
rvm --create 1.9.2@rails31
}}}

All the gems are installed using bundler, so first install bundler:
{{{
gem install bundler --pre
}}}

And then install the Bookcamping dependencies
{{{
bundler install
}}}

To be continued....


## Testing

### How to run rspec test
Start spork:
{{{
spork
}}}
Open other shell and type:
{{{
rspec .
}}}

### How to run cucumber tests
Start spork:
{{{
sprok cucumber
}}}
Open other shell and type:
{{{
cucumber -p all
}}}
which means run all the tests, or
{{{
cucumber
}}}
to run only the current test (if any)

