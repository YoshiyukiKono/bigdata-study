
https://techblog.gmo-ap.jp/2018/12/03/spark-%E4%B8%A6%E5%88%97%E5%8C%96%E3%83%81%E3%83%A5%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0%E3%81%AE%E4%B8%80%E4%BE%8B/

```
val num = 2500000
def find_prime(num:Int):Unit = {
  val composite = sc.parallelize(2 to num, 8).map(x => (x, (2 to (num / x)))).flatMap(kv => kv._2.map(_ * kv._1))
  val prime_num = sc.parallelize(2 to num, 8).subtract(composite)
  prime_num.collect()
}
find_prime(num)
```

```
val num = 2500000
def find_prime(num:Int):Unit = {
  val composite = sc.parallelize(2 to num, 8).map(x => (x, (2 to (num / x)))).repartition(8).flatMap(kv => kv._2.map(_ * kv._1))
  val prime_num = sc.parallelize(2 to num, 8).subtract(composite)
  prime_num.collect()
}
find_prime(num)
```
