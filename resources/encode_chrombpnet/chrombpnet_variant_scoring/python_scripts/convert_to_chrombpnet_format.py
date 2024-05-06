import pandas as pd
import sys


def to_chrombpnet_format(vars_df):
    df = pd.DataFrame()
    df['chr'] = vars_df['variant'].apply(lambda x: x.split('_')[0])
    df['pos'] = vars_df['variant'].apply(lambda x: int(x.split('_')[1]))
    df['allele1'] = vars_df['variant'].apply(lambda x: x.split('_')[2])
    df['allele2'] = vars_df['variant'].apply(lambda x: x.split('_')[3])
    # df['rsid'] = vars_df['rsid']

    return df

if __name__ == '__main__':
    vars_df = pd.read_csv(sys.argv[1], sep='\t')
    to_chrombpnet_format(vars_df).to_csv(sys.argv[2],  sep='\t', index=False, header=None)