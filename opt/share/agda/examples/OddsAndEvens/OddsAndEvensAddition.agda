{-# OPTIONS --safe #-}
module OddsAndEvensAddition where

-- open import Preloaded
open import Data.Nat

data Even : ℕ → Set
data Odd  : ℕ → Set

data Even where
  zero : Even zero
  suc  : ∀ {n : ℕ} → Odd n → Even (suc n)

data Odd where
  suc : ∀ {n : ℕ} → Even n → Odd (suc n)
  
-- | Implement all these functions
infixl 6 _e+e_ _o+e_ _o+o_ _e+o_
_e+e_ : ∀ {m n : ℕ} → Even m → Even n → Even (m + n)
_o+e_ : ∀ {m n : ℕ} → Odd  m → Even n → Odd  (m + n)
_o+o_ : ∀ {m n : ℕ} → Odd  m → Odd  n → Even (m + n)
_e+o_ : ∀ {m n : ℕ} → Even m → Odd  n → Odd  (m + n)

_e+e_ {zero} {n} em en = en
_e+e_ {suc m} {n} (suc om) en = suc (om o+e en)

_o+e_ {zero} {n} () en
_o+e_ {suc m} {n} (suc em) en = suc (em e+e en)

_o+o_ {zero} {n} ()
_o+o_ {suc m} {n} (suc em) on = suc (em e+o on)

_e+o_ {zero} {n} ez on = on
_e+o_ {suc m} {n} (suc om) on = suc (om o+o on)
