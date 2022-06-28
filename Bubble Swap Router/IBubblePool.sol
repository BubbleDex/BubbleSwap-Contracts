// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import 'IBubblePoolImmutables.sol';
import 'IBubblePoolState.sol';
import 'IBubblePoolDerivedState.sol';
import 'IBubblePoolActions.sol';
import 'IBubblePoolOwnerActions.sol';
import 'IBubblePoolEvents.sol';

/// @title The interface for a Bubble Pool
/// @notice A Bubble pool facilitates swapping and automated market making between any two assets that strictly conform
/// to the ERC20 specification
/// @dev The pool interface is broken up into many smaller pieces
interface IBubblePool is
    IBubblePoolImmutables,
    IBubblePoolState,
    IBubblePoolDerivedState,
    IBubblePoolActions,
    IBubblePoolOwnerActions,
    IBubblePoolEvents
{

}