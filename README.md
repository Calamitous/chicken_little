Chicken Little
--------------

A remote web server monitoring script.  Because sometimes the sky really is falling.

This is a simple remote monitoring script I threw together to keep an eye on a couple of servers that were experiencing hiccups.

It simply checks the response codes of any URLs you feed it, and emails you if any of them fail.

It is designed to reside on server other than the one you're monitoring.  Preferably a different network/host/OS/etc.  Never underestimate the potential for all your infrastructure to fail simulatneously.

Usage
-----

Configuration is handled in the CONFIG hash at the top of the file.  Tweak it to suit your needs.  Once it's all configured, chmod 777 it, and run the script:

    chicken_little.rb

It will spit out a list of responses (or exceptions) it receives:

    200
    200
    Connection refused - connect(2)
    500

...and send emails to everyone in the recipients list for each response that is not a "200".

It's called "Chicken Little" because it will light off an email even for "OK" response codes, like 302s, so choose your URLs carefully.

You can automate it with a cron job.  Edit your crontab:

    crontab -e

...and set it to run once an hour

    0 1 * * * /home/zoltar_the_infallible/bin/chicken_little.rb

I STRONGLY RECOMMEND putting in a garbage URL and manually running your script to make sure you receive an outage notification.  Your SMTP settings are surprisingly easy to screw up, and you don't want to find your dumb config mistake after a client has called you to let you know the site's down.

Purpose
-------

No reporting, no fancy options, just a there-or-not panic button in less than 50 lines of code.  Works for me, but YMMV.

