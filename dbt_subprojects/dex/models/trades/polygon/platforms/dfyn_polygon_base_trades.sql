{{
    config(
        schema = 'dfyn_polygon',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v2_trades(
        blockchain = 'polygon',
        project = 'dfyn',
        version = '1',
        Pair_evt_Swap = source('dfyn_polygon', 'UniswapV2Pair_evt_Swap'),
        Factory_evt_PairCreated = source('dfyn_polygon', 'UniswapV2Factory_evt_PairCreated')
    )
}}
