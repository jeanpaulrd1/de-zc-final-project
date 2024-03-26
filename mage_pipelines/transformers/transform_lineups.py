import pandas as pd
from statsbombpy import sb


from ast import literal_eval
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    data['team_id'] = data['team_id'].astype(int)
    data['team_name'] = data['team_name'].astype(str)
    data['lineup'] = data['lineup'].astype(object)
    

    #data['lineup'] = data['lineup'].map(lambda x: eval(x) if pd.notnull(x) else x)
    #
    #test = pd.json_normalize(data['lineup'])
    #pd.concat(data, test, axis = 1)
    return sb.competitions()


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
