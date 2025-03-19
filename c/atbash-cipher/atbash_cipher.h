#ifndef ATBASH_CIPHER_H
#define ATBASH_CIPHER_H

// Returns an encrypted copy of the input string. The copy is encrypted using
// the atbash cipher.
char *atbash_encode(const char *input);

// Returns a decrypted copy of the given input string. The input string must be
// encrypted using atbash cipher.
char *atbash_decode(const char *input);

#endif
