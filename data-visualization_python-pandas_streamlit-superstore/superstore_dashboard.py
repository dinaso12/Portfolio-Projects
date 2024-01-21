import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import streamlit as st
import plotly.express as px
import millify
import altair as alt
import time
from pandas.tseries.offsets import DateOffset
import matplotlib.pyplot as plt
import plotly.graph_objects as go

start_time = time.time()


@st.cache_data
def get_data():
# Read data
    superstore_df = pd.read_csv('data.csv', index_col = 'Row ID')

# Correct Ship Date and calculate Days to Ship column from Order Date and Ship Date
    superstore_df['Order Date'] = pd.to_datetime(superstore_df['Order Date'])
    superstore_df['Year'] = superstore_df['Order Date'].dt.year
    superstore_df['Year'] = superstore_df['Year'].astype(str)
    superstore_df['Ship Date'] = superstore_df['Ship Date'].str[:-4]
    superstore_df['Ship Date'] = superstore_df['Ship Date'] + superstore_df['Year']
    superstore_df['Ship Date'] = pd.to_datetime(superstore_df['Ship Date'])
    superstore_df.loc[superstore_df['Ship Date'] < superstore_df['Order Date'], 'Ship Date'] = superstore_df['Ship Date']+ DateOffset(years=1)
    superstore_df['Days to Ship'] = superstore_df['Ship Date'] - superstore_df['Order Date']
    superstore_df['Year'] = superstore_df['Year'].astype(int)
    return superstore_df

# Filter data

def filtered_data_by_year():
    return get_data().query('Year == @selected_years')

def get_years():
    data = get_data()
    years = data['Year'].unique().tolist()
    return sorted(years)

# Calculaions

def get_total(column):
    df = filtered_data_by_year()
    return df[column].sum()

def count_orderID():
    df = filtered_data_by_year()
    return len(df.groupby(by='Order ID').count())

def delta_metric(column):
    if len(selected_years) == 1:
        if selected_years != min(get_years()):
            selected_years_prev = selected_years[0]-1
            total_act = get_total(column)
            df_prev = get_data().query('Year == @selected_years_prev')
            total_prev = df_prev[column].sum()
            delta_metric = ((total_act - total_prev)/total_prev)*100
            return "{:.1f}%".format(delta_metric)
        else:
            return None
    else:
        return None
    
def delta_metric_count():
    if len(selected_years) == 1:
        if selected_years != min(get_years()):
            selected_years_prev = selected_years[0]-1
            count_act = count_orderID()
            df_prev = get_data().query('Year == @selected_years_prev')
            count_prev = len(df_prev.groupby(by='Order ID').count())
            delta_metric = ((count_act - count_prev)/count_prev)*100
            return "{:.1f}%".format(delta_metric)
        else:
            return None
    else:
        return None


# Dashboard

with st.sidebar:
    selected_years = st.multiselect(label='Select years:', options= get_years(), default = get_years())

cont0 = st.container()
cont0.title("Superstores")

cont1 = st.container()
with cont1:
    col1, col2, col3 = st.columns(3)
    with col1:
        st.metric("Total Sales:", value='$' + millify.millify(get_total('Sales'), precision= 1), delta=(delta_metric('Sales')))
    with col2:
        st.metric("Total Profit:", value='$' + millify.millify(get_total('Profit'), precision= 1), delta=(delta_metric('Profit')))
    with col3:
        st.metric("Total Orders:", value= count_orderID(), delta = delta_metric_count())

cont2 = st.container()

sunset_colors = ["#4B0082", "#8A2BE2", "#E97451", "#FF6B6B", "#DC143C", "#FFDAB9", "#FFA500", "#FFD700", "#FF00FF", "#E6E6FA"]

with cont2:
    col1, col2 = st.columns(2)
    with col1:
        top10_products_sales = filtered_data_by_year().groupby('Product Name').sum().sort_values('Sales', ascending=False).head(10)
        color_scale = alt.Scale(domain=list(top10_products_sales.reset_index().head(10)['Product Name'].values), range=sunset_colors)
        chart2 = alt.Chart(top10_products_sales.reset_index()).mark_bar(opacity=0.9).encode(
        x='sum(Sales):Q',
        y=alt.Y('Product Name:N', sort='-x'),
        color=alt.Color('Product Name:N', scale=color_scale, legend=None),
        text='sum(Sales):Q')

        chart2 = chart2.properties(title="Top 10 Selling Products" )

        st.altair_chart(chart2, use_container_width=True)
         
    with col2:
        top10_products_profit = filtered_data_by_year().groupby('Product Name').sum().sort_values('Profit', ascending=False).head(10)
        color_scale = alt.Scale(domain=list(top10_products_profit.reset_index().head(10)['Product Name'].values), range=sunset_colors)
        chart2 = alt.Chart(top10_products_profit.reset_index()).mark_bar(opacity=0.9).encode(
        x='sum(Profit):Q',
        y=alt.Y('Product Name:N', sort='-x'),
        color=alt.Color('Product Name:N', scale=color_scale, legend=None),
        text='sum(Profit):Q')

        chart2 = chart2.properties(title="Top 10 Profitable Products" )

        st.altair_chart(chart2, use_container_width=True)    

st.write(top10_products_profit[['Sales', 'Profit']])

average_shipping_days = pd.to_numeric(filtered_data_by_year()['Days to Ship'].dt.days.mean(), downcast='integer')

fig = go.Figure(go.Indicator(
    mode = "gauge+number",
    value = average_shipping_days,
    title = {'text': "Average shipping days"},
    domain = {'x': [0, 1], 'y': [0, 1]},
    gauge={'axis': {'range': [None, 100]},
           'bar': {'color': "#4B0082"}}))

st.plotly_chart(fig)

cat_pivot_table = get_data().pivot_table(index='Year', columns='Category', values='Sales', aggfunc='sum', fill_value=0)
cat_pivot_table = cat_pivot_table.reset_index().melt(id_vars='Year', var_name='Category', value_name='Sales')

category_colors = {'Furniture':"#4B0082", 'Office Supplies':"#8A2BE2", 'Technology':"#E97451"}
chart3 = alt.Chart(cat_pivot_table).mark_bar().encode(
        y=alt.Y('sum(Sales):Q', stack='zero', axis=alt.Axis(format='~s') ),
        x=alt.X('Year:N'),
        color=alt.Color('Category:N', scale=alt.Scale(domain=list(category_colors.keys()), range=list(category_colors.values()))))

st.altair_chart(chart3, use_container_width=True)

end_time = time.time()
execution_time = end_time - start_time
st.write(f"Execution time: {execution_time} seconds")

