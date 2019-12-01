## Filter Word

## Word Count

...

## Summation and Min/Max/Average
```

```

## Calculation for each status

- countByKey()
- groupByKey()
- reduceByKey()
- aggregateByKey()
- combineByKey()

## Calculation with combination and aggragation

- combineByKey
- aggregateByKey

```
ordersKeyValue = orders.map(lambda line: (int(line.split(",")[0], line))

orderItemsKeyValue = orderItems.map(lambda line: (int(line.split(",")[1], line))

joinedData = orderItemsKeyValue.join(ordersKeyValue)

# Format of joinedData as below.
# [OrderId, 'All columns from orderItemsKeyValue', 'All columns from ordersKeyValue']

# TODO

```

## Join

```
ordersKeyValue = orders.map(lambda line: (int(line.split(",")[0], line))

orderItemsKeyValue = orderItems.map(lambda line: (int(line.split(",")[1], line))

joinedData = orderItemsKeyValue.join(ordersKeyValue)

# Format of joinedData as below.
# [OrderId, 'All columns from orderItemsKeyValue', 'All columns from ordersKeyValue']
ordersPerDatePerCustomer = joinedData.map(lambda line:((line[1][1].split(",")[1], line[1][1].split(",")[2]), float(line[1][0].split(",")[4])))
amountCollectedPerDatePerCustomer = ordersPerDatePerCustomer.reduceByKey(lambda line: runningSum, amount: runningSum + amount)

# Out record format will be ((date, customer_id)), totalAmount)

# Change the format of record as (date, (customer_id, totalAmount))
revenuePerDatePerCustomer = amountCollectedPerDatePerCustomer.map(lambda threeElementTuple: (threeElementTuple[0][0], (threeElementTuple[0][1], threeElementTuple[1])))


perDateMaxAmountCollectedByCustomer = revenuePerDatePerCustomer.reduceByKey(lambda runningAmountTuple, newAmountTuple: 
                      (runningAmountTuple if runningAmountTuple[1] >= newAmountTuple[1]threeElementTuple[0][0] else newAmountTuple))
                      
```

## Sort

```
# sort in ascending order
sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),(line.split(",")[2])).sortByKey()
for line in sortedPriceProducts.collect():
  print(line)

# sort in descending order
sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),(line.split(",")[2])).sortByKey(False)
for line in sortedPriceProducts.collect():
  print(line)

sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),(line.split(",")[2])).sortByKey(False).take(1)


sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),(line.split(",")[2])).sortByKey(False).take(1)


sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),int(line.split(",")[1]),line.split(",")[2])).sortByKey(False).take(10)

sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),int(line.split(",")[1]),line.split(",")[2])).sortByKey(False).top(10)

sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),int(line.split(",")[1]),line.split(",")[2])).takeOrdered(10, lambda tuple: (tuple[0][0]), tuple[0][1])

# Using minus(-) parameter can help you to make descending ordering, only for numeric value.
sortedPriceProducts = nonempty_lines.map(lambda line: (float(line.split(",")[4]),int(line.split(",")[1]),line.split(",")[2])).takeOrdered(10, lambda tuple: (-tuple[0][0]), tuple[0][1])


```

##  Sort by A per(group by) B

Data: product_id, product_category_id, product_name, product_description, product_price, product_image

```python
productsRDD = sc.textFile("...")
nonempty_lines = producstRDD.filter(lambda x: len(x.split(",")[4]) > 0)
mappedRDD = nonempty_lines.map(lambda line: (line.split(",")[1],(line.split(",")[0],line.split(",")[2],line.split(",")[4]))))
for line in mappedRDD.collect(): print(line)

groupByCategoryId = mappedRDD.groupByKey()
for line in groupByCategoryId.collect(): print(line)

groupByCategoryId.map(lambda tuple: sorted(touple[1], key=lambda toupleValue: taoubleValue[2])).take(5)

groupByCategoryId.map(lambda tuple: sorted(touple[1], key=lambda toupleValue: taoubleValue[2], reverse=True)).take(5)

```
