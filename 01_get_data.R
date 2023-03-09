library(fec16)

## Read individuals data 
individuals <- fec16::read_all_individuals()
write.csv(individuals, file = './individuals.csv')

## Read campaign data 
contributions <- fec16::read_all_contributions()

fec16::read_all_

fec16::