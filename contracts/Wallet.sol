// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./Layers.sol";

contract Wallet {
  using Layers for Layers.Layer;


  struct AmountMinMax {
    uint256 min;
    uint256 max;
  }

  struct Layer {
    AmountMinMax amount;

    uint numTokens;
    mapping (uint => string) tokens;

    uint numLayers;
    mapping (uint => Layers.Layer) layerFlow;
  }


  uint numLayersToMakeTransfer;
  mapping (uint => Layer) LayersToMakeTransfer;

  uint numTransferLayers;
  mapping (uint => mapping (uint => Layer)) TransferLayers;

  struct Transfer {
    uint256 transferNum;

    address receiver;
    uint256 amount;

    uint256 transferLayersIndex;

    bool executed;
  }

  uint numTransfers;
  mapping (uint => Transfer) Transfers;


  function addLayerToMakeTransfer(
    uint256 _amountMin,
    uint256 _amountMax
  ) private {
    Layer storage layer = LayersToMakeTransfer[numLayersToMakeTransfer];

    AmountMinMax memory amount = AmountMinMax({
      min: _amountMin,
      max: _amountMax
    });

    layer.amount = amount;

    // TODO: not hard coded
    string [2] memory _tokens = [ "ETH", "USDC" ];

    for (uint i = 0; i < _tokens.length; i++) {
      string memory token = _tokens[i];

      layer.tokens[i] = token;

      layer.numTokens++;
    }

    // TODO: not hard coded
    // Start here
    for (uint seqNum = 0; seqNum < 4; seqNum++) {
      for (uint layerInSeqNum = 0; layerInSeqNum < 3; layerInSeqNum++) {
        Layer memory layer = XXX.layerFlow[XXX INDEX]
        layer.type = ENUM SMTH;
      }

      Layer memory layer = XXX.layerFlow[XXX INDEX];
      layer.type = ENUM SMTH;
      layer.isSeqSep = true;
    }

    numLayersToMakeTransfer++;
  }


  function makeTransfer(
    address _receiver,
    uint256 _amount
  ) private {
    addTransferLayers();
    addTransfer(_receiver, _amount);

    // Check that numTransferLayers equals numTransfers
    // Queue transfers until this one is done with the 2 funcs above
    // Lock parts of the code
  }

  function addTransferLayers() private {
    for (uint layerNum = 0; layerNum < numLayersToMakeTransfer; layerNum++) {
      Layer storage _layer = LayersToMakeTransfer[layerNum];

      Layer storage layer = TransferLayers[numTransfers][layerNum];

      AmountMinMax memory amount = AmountMinMax({
        min: _layer.amount.min,
        max: _layer.amount.max
      });

      layer.amount = amount;

      layer.numTokens = _layer.numTokens;

      for (uint tokenNum = 0; tokenNum < _layer.numTokens; tokenNum++) {
        string memory token = _layer.tokens[tokenNum];

        layer.tokens[tokenNum] = token;
      }
      
      numTransferLayers++;
    }
  }

  function addTransfer(
    address _receiver,
    uint256 _amount
  ) private {
    Transfer storage transfer = Transfers[numTransfers];

    transfer.transferNum = numTransfers;

    transfer.receiver = _receiver;
    transfer.amount = _amount;

    transfer.transferLayersIndex = numTransfers;

    transfer.executed = false;

    numTransfers++;
  }




  // LayersToMakeTransfer
  event TestLogNumLayersToMakeTransfer(uint _numLayersToMakeTransfer);
  event TestLogLayerToMakeTransfer(
    uint _layerNum,
    uint256 _amountMin,
    uint256 _amountMax,
    uint _numTokens
  );

  // TransferLayers
  event TestLogNumTransferLayers(uint _numTransferLayers);
  event TestLogTransferLayer(
    uint _transferNum,
    uint _transferLayerNum,
    uint256 _amountMin,
    uint256 _amountMax,
    uint256 _numTokens
  );

  // Transfers
  event TestLogNumTransfers(uint _numTransfers);
  event TestLogTransfer(
    uint256 _transferNum,
    address _receiver,
    uint256 _amount,
    uint256 _transferLayersIndex,
    bool _executed
  );


  function test(address _receiver) public virtual {
    testSetLayersToMakeTransfer();
    testLogLayersToMakeTransfer();

    uint256 amount = 1000;
    
    testMakeTransfer(_receiver, amount);
    testMakeTransfer(_receiver, amount);
    testMakeTransfer(_receiver, amount);
    testMakeTransfer(_receiver, amount);
    testMakeTransfer(_receiver, amount);
    testMakeTransfer(_receiver, amount);
    testMakeTransfer(_receiver, amount);
    testMakeTransfer(_receiver, amount);

    testLogTransferLayers();
    testLogTransfers();
  }

  function testSetLayersToMakeTransfer() private {
    addLayerToMakeTransfer(0, 100);
    addLayerToMakeTransfer(100, 120);
  }

  function testLogLayersToMakeTransfer() private {
    emit TestLogNumLayersToMakeTransfer(numLayersToMakeTransfer);

    for (uint layerNum = 0; layerNum < numLayersToMakeTransfer; layerNum++) {
      Layer storage layer = LayersToMakeTransfer[layerNum];

      uint256 amountMin = layer.amount.min;
      uint256 amountMax = layer.amount.max;

      uint numTokens = layer.numTokens;

      /*
      for (uint tokenNum = 0; tokenNum < _layer.numTokens; tokenNum++) {
        string memory token = _layer.tokens[tokenNum];

        layer.tokens[tokenNum] = token;
      }
      */
      
      emit TestLogLayerToMakeTransfer(
        layerNum,
        amountMin,
        amountMax,
        numTokens
      );
    }
  }

  function testMakeTransfer(
    address _receiver,
    uint256 _amount
  ) private {
    makeTransfer(_receiver, _amount);
  }

  // mapping (uint => mapping (uint => Layer)) TransferLayers;
  function testLogTransferLayers() private {
    emit TestLogNumTransferLayers(numTransferLayers);

    for (uint transferNum = 0; transferNum < numTransfers; transferNum++) {
      for (uint transferLayerNum = 0; transferLayerNum < numTransferLayers; transferLayerNum++) {
        Layer storage layer = TransferLayers[transferNum][transferLayerNum];

        uint256 amountMin = layer.amount.min;
        uint256 amountMax = layer.amount.max;

        uint numTokens = layer.numTokens;

        emit TestLogTransferLayer(
          transferNum,
          transferLayerNum,
          amountMin,
          amountMax,
          numTokens
        );
      }
    }
  }

  function testLogTransfers() private {
    emit TestLogNumTransfers(numTransfers);

    for (uint _transferNum = 0; _transferNum < numTransfers; _transferNum++) {
      Transfer storage transfer = Transfers[_transferNum];

      uint256 transferNum = transfer.transferNum;

      address receiver = transfer.receiver;
      uint256 amount = transfer.amount;

      uint256 transferLayersIndex = transfer.transferLayersIndex;

      bool executed = transfer.executed;

      emit TestLogTransfer(
        transferNum,

        receiver,
        amount,

        transferLayersIndex,

        executed
      );
    }
  }
}
