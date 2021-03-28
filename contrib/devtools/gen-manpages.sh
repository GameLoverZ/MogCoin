#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

MOGCOIND=${MOGCOIND:-$BINDIR/mogcoind}
MOGCOINCLI=${MOGCOINCLI:-$BINDIR/mogcoin-cli}
MOGCOINTX=${MOGCOINTX:-$BINDIR/mogcoin-tx}
MOGCOINQT=${MOGCOINQT:-$BINDIR/qt/mogcoin-qt}

[ ! -x $MOGCOIND ] && echo "$MOGCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
MOCVER=($($MOGCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for mogcoind if --version-string is not set,
# but has different outcomes for mogcoin-qt and mogcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$MOGCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $MOGCOIND $MOGCOINCLI $MOGCOINTX $MOGCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${MOCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${MOCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
