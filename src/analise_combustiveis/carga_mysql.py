import os
from pathlib import Path

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, types
from sqlalchemy.engine import URL

load_dotenv()

ROOT = Path(__file__).resolve().parents[2]
CSV = ROOT / "data" / "processed" / "precos_capitais.csv"

url = URL.create(
    "mysql+pymysql",
    username=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST", "localhost"),
    database=os.getenv("DB_NAME"),
)
engine = create_engine(url)

df = pd.read_csv(CSV, parse_dates=["data_inicial", "data_final"])
df = df.drop(columns=["arquivo"])

TIPOS = {
    "data_inicial": types.Date(),
    "data_final": types.Date(),
    "estado": types.String(50),
    "municipio": types.String(50),
    "produto": types.String(30),
    "n_postos": types.Integer(),
    "unidade": types.String(10),
    "preco_medio": types.Numeric(6, 3),
    "desvio_padrao": types.Numeric(8, 6),
    "preco_min": types.Numeric(6, 3),
    "preco_max": types.Numeric(6, 3),
    "coef_variacao": types.Numeric(6, 3),
}

df.to_sql(
    "precos_capitais",
    engine,
    if_exists="replace",
    index=False,
    dtype=TIPOS,
    chunksize=1000,
)
print(f"{len(df)} linhas carregadas")