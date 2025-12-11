# syntax=docker.io/docker/dockerfile:1

ARG LEAP_VERSION=15.6
ARG INSTALL_ROOT=/rootfs

FROM opensuse/leap:${LEAP_VERSION} AS builder
ARG CACHE_ZYPPER=/tmp/cache/zypper
ARG INSTALL_ROOT
RUN <<HEREDOC
  # Remove the `openh264` the `non-oss` repos to save on sync time, they're not needed:
  zypper removerepo repo-openh264 repo-non-oss repo-update-non-oss
  # `/etc/os-release` provides the `VERSION_ID` variable for usage in `ZYPPER_OPTIONS`:
  source /etc/os-release
  export ZYPPER_OPTIONS=( --releasever "${VERSION_ID}" --installroot "${INSTALL_ROOT}" --cache-dir "${CACHE_ZYPPER}" )

  # Install packages to a custom root-fs location (defined in `ZYPPER_OPTIONS`):
  zypper "${ZYPPER_OPTIONS[@]}" --gpg-auto-import-keys refresh
  zypper "${ZYPPER_OPTIONS[@]}" --non-interactive install --download-in-advance --no-recommends \
    bash procps grep gawk sed coreutils busybox ldns libidn2-0 socat openssl curl

  # Optional - Avoid `CACHE_ZYPPER` from being redundantly cached in this RUN layer:
  # (doesn't improve `INSTALL_ROOT` size thanks to `--cache-dir`)
  zypper "${ZYPPER_OPTIONS[@]}" clean --all

  # Cleanup (reclaim approx 13 MiB):
  # None of this content should be relevant to the container:
  rm -r "${INSTALL_ROOT}/usr/share/"{licenses,man,locale,doc,help,info} \
    "${INSTALL_ROOT}/usr/share/misc/termcap" \
    "${INSTALL_ROOT}/usr/lib/sysimage/rpm"
HEREDOC


# Create a new image with the contents of ${INSTALL_ROOT}
FROM scratch AS base-leap
ARG INSTALL_ROOT
COPY --link --from=builder ${INSTALL_ROOT} /
RUN <<HEREDOC
  # Creates symlinks for any other commands that busybox can provide that
  # aren't already provided by coreutils (notably hexdump + tar, see #2403):
  # NOTE: `busybox --install -s` is not supported via the leap package, manually symlink commands.
  ln -s /usr/bin/busybox /usr/bin/tar
  ln -s /usr/bin/busybox /usr/bin/hexdump
  ln -s /usr/bin/busybox /usr/bin/xxd

  # Add a non-root user `testssl`, this is roughly equivalent to the `useradd` command:
  # useradd --uid 1000 --user-group --create-home --shell /bin/bash testssl
  echo 'testssl:x:1000:1000::/home/testssl:/bin/bash' >> /etc/passwd
  echo 'testssl:x:1000:' >> /etc/group
  echo 'testssl:!::0:::::' >> /etc/shadow
  install --mode 2755 --owner testssl --group testssl --directory /home/testssl

  # A copy of `testssl.sh` will be added to the home directory,
  # symlink to that file so it can be treated as a command:
  ln -s /home/testssl/testssl.sh /usr/local/bin/testssl.sh
HEREDOC

# Runtime config:
USER testssl
ENTRYPOINT ["testssl.sh"]
CMD ["--help"]

# Final image stage (add `testssl.sh` project files)
# Choose either one as the final stage (defaults to the last stage, `dist-local`)

# 62MB Image (Remote repo clone, cannot filter content through `.dockerignore`):
FROM base-leap AS dist-git
ARG GIT_URL=https://github.com/testssl/testssl.sh.git
ARG GIT_BRANCH
ADD --chown=testssl:testssl ${GIT_URL}#${GIT_BRANCH?branch-required} /home/testssl

# 54MB Image (Local repo copy from build context, uses `.dockerignore`):
FROM base-leap AS dist-local
COPY --chown=testssl:testssl . /home/testssl/
