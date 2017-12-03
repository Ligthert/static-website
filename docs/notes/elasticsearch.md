# Closing a large group of indices
    for index in `cat somefile`; do echo -n "$index: "; curl -XPOST http://yourserver:9200/$index/_close ; echo; done

# Automatically close indices
    git clone https://github.com/elasticsearch/curator.git
    pip install -r requirements.txt
    ./run_curator.py --dry-run --host localhost close indices --older-than 7 --time-unit days --timestring %Y.%m.%d

# Do remote reindexes from a list in a file
    for index in `cat your_list`; do curl -XPOST 'int_host:9200/_reindex?pretty' -H 'Content-Type: application/json' -d"{ \"source\": { \"remote\": { \"host\": \"http://ext_host:9200\" }, \"index\": \"$index\", \"query\": { \"match\": { \"some_field\" : \"some_val\" } } }, \"dest\": { \"index\": \"$index\" } }"; done
