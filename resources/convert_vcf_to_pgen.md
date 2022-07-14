### Convert genotypes in VCF format to PLINK2 binary dosage format (pgen)

```bash
module load any/plink2/20211217
plink2 --vcf INTERVAL.filtered.vcf.gz dosage=DS --make-pgen --out INTERVAL
```


