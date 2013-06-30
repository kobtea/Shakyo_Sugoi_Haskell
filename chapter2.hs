-- 2章 型を信じろ！


-- 2.1 明示的な型宣言
-- 型を調べるには:tを使う
-- :t 'a'

-- 小文字を取り除く
removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

-- 3つの整数を受け取り、総和を返す
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z


-- 2.2 一般的なHaskellの型
{-
Int     整数
Integer 巨大な整数
Float   単精度浮動小数点
Double  倍精度浮動小数点
Bool    真理値
Char    Unicode文字列
-}
factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r


-- 2.3 型変数
{-
:t head
head :: [a] -> a
このaを型変数と呼び、どんな方も取りうる
型が小文字から始まるものは型変数
型変数を用いた関数を多相的関数と呼ぶ
-}


-- 2.4 型クラス 初級講座
{-
型クラスは何らかの振る舞いを定義するインターフェイス
型クラスは関数の集まりを定める
型クラスに属する関数をメソッドと呼ぶ
-}
{-
:t (==)
(==) :: Eq a => a -> a -> Bool

関数の名前が特殊文字のみからなる場合、その関数はデフォルトで中置関数になる
- 型を調べたい時
- 他の関数に渡したい時
- 前置関数として呼び出す時
には()をつけること

=>シンボルよりも前にあるのは型クラス制約と呼ぶ
「等値性関数は、同じ型の任意の2つの引数を取り、Boolを返す。引数の2つの値の型はEqクラスのインスタンスでなければならない」

Eq型クラスは等値性テストのためのインターフェイスを提供する
2つの値の等値性を比較することに意味があるなら、その型はEq型クラスのインスタンスにできる
Haskellの全ての標準型(I/O型と関数を除く)はEqのインスタンス
-}

-- Eq型クラス
{-
Eqのインスタンスが実装すべき関数とは、==と/=
関数の型変数にEqクラスの制約がついていたら、その関数の定義のどこかで==, /=が使用されている
型が関数を実装しているとは、その関数がその特定の方に対して使われた時に、どういう振る舞いをするか定義すること
-}

-- Ord型クラス
{-
ordは何らかの順序を付けられる型のための型クラス
関数は除いて、すべてOrdのインスタンス
Ordはすべての標準的な大小比較関数>, <, >=, <=をサポートする

compare関数はOrdのインスタンスの型の引数をお2つ取り、Orderingを返す
OrderingはGT, LT, EQのいずれかの値を取る型
-}

-- Show型クラス
{-
ある値は、その型がShow型クラスのインスタンスになっていれば、文字列として表現できる
関数を除けば、すべてShowインスタンス

showは指定した値を文字列として表示する関数
-}

-- Read型クラス
{-
ReadはShowと対を成す
read関数は文字列を受け取り、Readインスタンスの型の値を返す
-}

{-
ここで注意！
> read "5" - 2
3
だけど
read "4"
だとエラーになる
> :t read
read :: Read a => String -> a
何返せばいいのかGHCiがわからない
この問題を解決するために、型注釈というものがある

型注釈は、式が取るべき型をHaskellに明示的に教える
> read "4" :: Int
-}

-- Enum型クラス
{-
順番に並んだ型、つまり要素の値を列挙できる型
Enum型の利点は、その値をレンジの中で使えること
Enumインスタンスの方には後者関数succ, 前者関数predも定義される
Enumクラスのインスタンスには、(), Bool, Char, Ordering, Int, Integer, Float, Doubleがある
-}

-- Bounded型クラス
{-
上限と下限を持ち、それぞれminBoundとmaxBound関数で調べられる
> minBound :: Int
> maxBound :: Int
> maxBound :: Bool
> minBound :: Bool
minBound, maxBoundは(Bounded a) => aという型を持つ
これは、多相定数である
タプルの全ての構成要素がBoundedのインスタンスならば、そのタプル自身もBoundedになる
> maxBound :: (Int, Bool, Char)
-}

-- Num型クラス
{-
数の型クラス
あらゆる数もまた多相定数値として表現されている
ある型をNumのインスタンスにするには、その型がすでにShowとEqのインスタンスになっている必要がある(GHC 7.4.1からこの制限は廃止)
-}

-- Floating型クラス
{-
FloatとDoubleが含まれる
浮動小数点に使う
-}

-- Integral型クラス
{-
数の型クラス
Numが実数を含む全ての数を含む一方、Integralには整数のみが含まれる
この型クラスのいはIntとIntegerが含まれる

fromIntegralとか便利だよ
IntとFloatを足したい時、fromIntegral(Int) + Floatとかにすればいい
-}
