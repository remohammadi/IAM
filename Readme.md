# IAM
Identity and Access Management, in docker, with minimal configuration.

## Usage

### Command

	$ docker run --name=iam -p 80:80 -p 443:443 -p 389:389 -p 636:636 -v <PATH>/config:/etc/IAM:ro -v <PATH>/content:/content:ro -v <PATH>/runtime:/var/IAM/:rw -v <PATH>/logs:/var/logs/IAM:rw -e BASE_DN="dc=cafebazaar,dc=ir" -e ROOT_PASSWORD="test" -e TZ="Asia/Tehran" -e DC="cafebazaar" remohammadi/iam

### Volumes

* `/etc/IAM`: Should contains:
  * `key.pem` and `cert.pem` – Certificate for the domain.
  * `nginx-inside-default-http.conf`, `nginx-inside-default-https.conf`,
    `nginx-extra.conf` – See `assets/nginx.conf`.
* `/content/`
  * `/content/web/`: Files in this folder will be available on http server.
  * `/content/web/files/`: Like other files in web, but with auto-index
  * `/content/web/secure/`: Like `/content/web/files/` but only through https.

## TODO

* Generate a valid config to be placed into `/var/IAM/openam`, to get rid of
  the openam setup wizard.
* checking LDAPS
