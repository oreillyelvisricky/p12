// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

library Layers {
  struct Layer {
    bool isSeqSep;

    bool started;
    bool success;
    bool failure;
  }
}
