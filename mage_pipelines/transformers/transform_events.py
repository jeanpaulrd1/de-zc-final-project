import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data.dropna(subset=['player_id'], inplace= True)
    data['player_id'] = data['player_id'].astype(int)
    
    data = data[['id','match_id','duration','foul_committed_card','foul_committed_penalty','interception_outcome','minute','pass_goal_assist','pass_recipient','pass_technique','pass_type','period','play_pattern','player','player_id','position','possession','possession_team','possession_team_id','related_events','team','type','shot_outcome','shot_statsbomb_xg','shot_technique','shot_type','foul_committed_type', 'duel_outcome','duel_type','pass_outcome']]
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'