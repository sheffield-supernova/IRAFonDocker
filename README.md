# Can Docker run 32-bit IRAF on a 64-bit Catalina Mac?

Short answer: yep.

Apparently, using socat one can also run x-windows (which used to cause IRAF, in particular xgterms, to crash on Mojave, as well)

If you have Docker installed on your machine, download the Dockfile and run:

    docker build -t irafmachine .

This will create the docker image *irafmachine*.

To access the full range of x-window utilities, you need to invoke *socat*, for which the following bash scriptlet can be used to both set up x-window forwarding and running the container with the appropriate parameters:

    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
    docker run -it -e DISPLAY=$(ipconfig getifaddr en0):0 \
                -v /tmp/.X11-unix:/tmp/.X11-unix \
                -v $1:/data irafmachine;

**Note** this installs the barest version of iraf (i.e. no special packages - just the stsci and gemini packages). There is a bare bones `login.cl` file.  From the command prompt, one has to run `xgterm` in `/home/iraf` and then invoke `cl`.  If you run the above as a script (e.g. `./runiraf`), adding the path to the directory containing your data (`./runiraf /where/is/my/data`), will automatically map that path to `/data` inside the container.
