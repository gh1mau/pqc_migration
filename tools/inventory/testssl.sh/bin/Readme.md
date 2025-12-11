
# Binaries

The precompiled binaries provided in this directory have extended support for weak crypto which is normally not in OpenSSL
or LibreSSL: 40+56 Bit, export/ANON ciphers, weak DH ciphers, weak EC curves, SSLv2 etc. -- all the dirty features needed for
testing if you just want to test with binaries. They also come with extended support for a few advanced cipher suites and/or
features which are not in the official branch like (old version of the) CHACHA20+POLY1305 and CAMELLIA 256 bit ciphers.

# Security notices

The important thing upfront: **DO NOT USE THESE BINARIES FOR PRODUCTION PURPOSES**, at least not on the server side. A lot of security restrictions have been removed because we want to test how bad the servers are.


# General

The (stripped) binaries this directory are all compiled from the [old OpenSSL snapshot](https://github.com/testssl/openssl-1.0.2.bad) which adds a few bits to [Peter
Mosman's openssl fork](https://github.com/PeterMosmans/openssl). The few bits are IPv6 support (except IPV6 proxy) and some STARTTLS backports. More, see the [README.md](https://github.com/testssl/openssl-1.0.2.bad/README.md). Also, as of now, a few CVEs were fixed.

Compiled Linux and FreeBSD binaries so far came from Dirk, other contributors see ../CREDITS.md . A few binaries were removed in the latest edition, which are Kerberos binaries and 32 Bit binaries. Those and binaries for more architectures can be retrieved from [contributed builds @ https://testssl.sh/](https://testssl.sh/contributed_binaries/). Those binaries are *not* stripped.


## Compilation instructions


See [https://github.com/testssl/openssl-1.0.2.bad/00-testssl-stuff/Readme.md](https://github.com/testssl/openssl-1.0.2.bad/00-testssl-stuff/Readme.md)



## Conderations regarding binaries

testssl.sh has emerged a longer while back, so in general these binaries are not needed anymore as weak crypto is covered by bash sockets if the binary from the vendor can't handle weak crypto. In a future release they might be be retired, as they do not provide a overall benefit. Also static linking with glibc doesn't work as flawlessly these days anymore as it used to be,

### Speed

Checks using binaries instead of bash sockets run a bit faster. However when using a default run, this is within the error margin and also depends on what the server is offering for ciphers and protocols. Of course also local issues play a role because of issues like file system caching. Here is a quick comparison for defaults run started from one ok-ish/beefy Linux 8 core system to one server IP each:

-----

public server     | remark               | runtimes supplied openssl [s] | runtimes /usr/bin/openssl [s] |
------------------|----------------------|-------------------------------| ------------------------------|
testssl.sh        | TLS 1.0 - 1.3        | 104, 77, 88, 97               | 106, 100, 95, 98
testssl.net       | no RSA ciph.,TLS>=1.2| 79, 76, 85, 80                | 73, 66, (107), 72
heise.de          | no TLS 1.0           | 102, 95, 104                  | 98, 95, 99
owasp.org         | TLS >= 1.2           | 85, 96, 105                   | 88, 97, 98
vulnerable old system | SSLv3 - TLS 1.2  | 100, 104, 103                 | 134, 138, 141

As you can see which binary you pick does not matter much. To start with: The standard deviation even for a single target can be much bigger -- only the last system is internal and not in the internet. And comparing different targets with respect to their runtime depends also what the server is offering in terms of ciphers, vulnerabilities etc. .

-----

### Capabilities

For modern servers the usage of the binaries provided by our project might come also with a limited value: They don't support e.g. TLS 1.3 and lack newer TLS 1.2 ciphers. They do support SSLv2 through TLS 1.2 though but servers with deprecated or vulnerable protocols protocols became less common.

One other thing worth to mention is that any binary can handle protocols on top of SSL/TLS better (or at all) once encrypted connection is established, like retrieving the HTTP header. OTOH as of 2024/2025 distributors/vendors however still support weaker crypto with TLS 1.0 or TLS 1.1, most of them even support SSLv3. That is possible with some tweaks which testssl.sh applies. So using older binaries like the ones in this directory are very often not needed.


