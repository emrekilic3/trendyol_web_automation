import pandas
from robot.api.deco import keyword


# Keyword that read and parse the dataset from a file

@keyword("Obtain product list from the dataset")
def get_product_list(file_name, column_name):
    word_list = pandas.read_excel(file_name)
    return word_list[column_name].values.tolist()
