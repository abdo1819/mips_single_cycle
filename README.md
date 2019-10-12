# arch_lab09

# releases
### 7,oct,19
* 8 instractions has been implemented and tested release link
[v0.8](https://github.com/abdo1819/arch_lab09/releases/tag/v0.8)
* doc for them [doc.pdf](Doc/doc10_7_2019__latest004.pdf)

instractions |jr    | jal| bne| andi| srl| lh   | lb | lbu
-----        |----|----|----|-----|----|----- |----|----        

### 8,oct,19
* merging 8 instractions from team2 [v0.16](https://github.com/abdo1819/arch_lab09/releases/tag/v0.16)

instractions |sll|lui|slti|blez|srlv|ori|xori|jr
-----        |----|----|----|-----|----|----- |----|---- 

## instractions progress
### weak 1
state|isntraction| team #  |comment            | doc 
-----|-----------|---------|-------------------|---------
✔    |jr         |     1   |                        |[jr__lbu.md](Doc/README__jr___lbu.md) 
✔    |jal        |     1   |                        | 
✔    |bne        |     1   |*already implemented*   | 
✔    |andi       |     1   |                        |[andi.md](Doc/andi.md)
✔    |srl        |     1   |                        |[srl.md](Doc/srl.md)
✔    |lh         |     1   |                        |[lb___lh.md](Doc/README___lb___lh.md)
✔    |lb         |     1   |                        |[lb___lh.md](Doc/README___lb___lh.md)
✔    |lbu        |     1   |                        |[jr__lbu.md](Doc/README__jr___lbu.md)
✔    |sll        |     2    |                       |
✔    |lui        |     2    |                       |
✔    |slti       |     2    |                       |
✔    |blez       |     2    |                       |
✔    |srlv       |     2    |                       | 
✔    |ori        |     2    |                       | 
✔    |xori       |     2    |                       | 
✔    |jr         |     2    |**duplicated**|
### weak 2
state|isntraction| team #  |comment            | doc 
-----|-----------|---------|-------------------|---------
☐    |addiu      |     1   |identical to addi       |    
☐    |sh         |     1   |                        |                              
☐    |sb         |     1   |                        |                              
☐    |sra        |     1   |                        |                               
☐    |sllv       |     1   |                        |                               
☐    |divu       |     1   |                        |                               
☐    |mult       |     1   |                        |                               
☐    |subu       |     1   |                        |                               
☐    |bgtz       |     2   |                        |
☐    |lhu        |     2   |                        |
☐    |sllv       |     2   |**duplicate**           |
☐    |srav       |     2   |                        |
☐    |sltiu      |     2   |                        |
☐    |xori       |     2   |                        |
☐    |jalr       |     2   |                        |


## todo 
- [ ] reduce mux2 count in datapath
- [ ] try to implement the processor according to  mips release 6
- [ ] and headings for this doc
- [ ] find general way for testing
- [ ] make schmatic for all instractions
