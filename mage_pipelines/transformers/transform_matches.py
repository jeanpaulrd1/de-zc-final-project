import pandas as pd 
from pandas.api.types import is_object_dtype

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data['match_id'] = data['match_id'].astype(int)
    data['match_date'] = pd.to_datetime(data['match_date'], infer_datetime_format=True)
    data['kick_off'] = data['kick_off'].astype(str)
    data['competition'] = data['competition'].astype(str)
    data['season'] = data['season'].astype(str)
    data['home_team'] = data['home_team'].astype(str)
    data['away_team'] = data['away_team'].astype(str)
    data['home_score'] = data['home_score'].astype(int)
    data['away_score'] = data['away_score'].astype(int)
    data['home_managers'] = data['home_managers'].astype(str)
    data['away_managers'] = data['away_managers'].astype(str)
    data['competition_stage'] = data['competition_stage'].astype(str)
    data['stadium'] = data['stadium'].astype(str)
    data['referee'] = data['referee'].astype(str)

    data = data[['match_id', 'match_date', 'kick_off','competition','season','home_team','away_team','home_score','away_score', 'home_managers','away_managers','competition_stage','stadium','referee']]


    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
