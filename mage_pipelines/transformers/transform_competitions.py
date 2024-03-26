import pandas as pd 

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data = data[['competition_id', 'season_id', 'country_name','competition_name','competition_gender','competition_international','season_name']]
    data['competition_id'] = data['competition_id'].astype(int)
    data['season_id'] = data['season_id'].astype(int)
    data['country_name'] = data['country_name'].astype(str)
    data['competition_name'] = data['competition_name'].astype(str)
    data['competition_gender'] = data['competition_gender'].astype(str)
    data['competition_international'] = data['competition_international'].astype(str)
    data['season_name'] = data['season_name'].astype(str)
    
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
