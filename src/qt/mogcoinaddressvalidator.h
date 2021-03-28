// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef MOGCOIN_QT_MOGCOINADDRESSVALIDATOR_H
#define MOGCOIN_QT_MOGCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class MogCoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MogCoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** MogCoin address widget validator, checks for a valid mogcoin address.
 */
class MogCoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MogCoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // MOGCOIN_QT_MOGCOINADDRESSVALIDATOR_H
