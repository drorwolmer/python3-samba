FROM python:3.7.0-stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
			 libacl1-dev python-dev python3-dev libldap2-dev libpam-dev \
		&& rm -rf /var/lib/apt/lists/*

RUN wget -q "https://download.samba.org/pub/samba/stable/samba-4.8.5.tar.gz" \
	&& tar -xf "samba-4.8.5.tar.gz" \
	&& cd /usr/local/bin && rm python && ln -s /usr/bin/python2 python \
	&& cd /samba-4.8.5 && chmod +x configure \
	&& ./configure --without-ad-dc \
	&& make -j 8 \
	&& make -j 8 install \
	&& cd / \
	&& rm -rf /samba*

# make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
        && rm -f python \
	&& ln -s python3 python

