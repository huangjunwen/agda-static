{-# OPTIONS --safe #-}
module OddsAndEvensMultiplication where

open import OddsAndEvensAddition
open import Data.Nat

-- | Implement these functions:
infixl 7 _e*e_ _o*e_ _o*o_ _e*o_
_e*e_ : ∀ {m n : ℕ} → Even m → Even n → Even (m * n)
_o*e_ : ∀ {m n : ℕ} → Odd  m → Even n → Even (m * n)
_o*o_ : ∀ {m n : ℕ} → Odd  m → Odd  n → Odd  (m * n)
_e*o_ : ∀ {m n : ℕ} → Even m → Odd  n → Even (m * n)

_e*e_ {zero} {n} ez en = ez
_e*e_ {suc m} {n} (suc om) en = en e+e (om o*e en)

_o*e_ {zero} {n} ()
_o*e_ {suc m} {n} (suc em) en = en e+e (em e*e en)

_o*o_ {zero} {n} () 
_o*o_ {suc m} {n} (suc em) on = on o+e (em e*o on)

_e*o_ {zero} {n} ez on = ez
_e*o_ {suc m} {n} (suc om) on = on o+o (om o*o on)