# -*- coding: utf-8 -*-
"""lab4.ipynb

Automatically generated by Colaboratory.
"""

import requests
from bs4 import BeautifulSoup

DOMAIN = 'https://old.herzen.spb.ru'
ATLAS_DOMAIN = 'https://atlas.herzen.spb.ru/'

def get_institutes_list():
    # получение списка институтов
    html = requests.get(DOMAIN + '/main/structure/inst/').text # получение исходного кода страницы

    inst_list = [] # список институтов

    bs = BeautifulSoup(html, 'html.parser') # инициализация BeautifulSoup
    nameList = bs.find('td', {'class': 'block'}) # выбор блока со ссылками на страницы институтов
    instList = nameList.ul.findAll('li') # перебор элементов списка
    for el in instList:
        # текст ссылки - название института
        link = el.a # получение ссылки на страницу института
        data = {'institute_name': link.text, "url": DOMAIN + link.get('href')}
        inst_list.append(data) # добавление информации в список

    return inst_list


def get_department_head_info(link):
    # получение информации в зав.кафедры (из Атласа)
    html = requests.get(ATLAS_DOMAIN + link).text # получение исходного кода страницы

    data = dict()
    
    bs = BeautifulSoup(html, 'html.parser') # инициализация BeautifulSoup
    title = bs.find('h3', text='Заведующий кафедрой:') # поиск заголовка на странице
    # после заголовка находится элемент span, в котором указаны ФИО и учёная степень зав.кафедры
    name = title.find_next_sibling()
    # ФИО указано до запятой
    name = name.span.text.split(',')[0]
    data['head_name'] = name # добавление в словарь

    email = '' # e-mail может быть не указан на странице
    
    # поиск в таблице (список сотрудников кафедры)
    table = bs.find('table', {'class': 'table_good'})
    for el in table.findAll('a'): # перебор всех ссылок в таблице
        teacher = el.text.strip() # удаление пробельных символов
        if teacher == data['head_name']: # если ФИО совпадает с ФИО зав.кафедры, то переходим по ссылке и получаем e-mail зав.кафедры
            link = el.get('href') # получаем ссылку

            html = requests.get(ATLAS_DOMAIN + link).text # получение исходного кода страницы
            bs = BeautifulSoup(html, 'html.parser') # инициализация BeautifulSoup
            title = bs.find('h3', text='E-mail:') # поиск заголовка
            if title: # e-mail указан
                email = title.find_next_sibling()
                email = email.span.a.text

    data['email'] = email # добавление в словарь
    
    return data


def get_institutes_data(institutes_list):
    # получение информации о кафедрах
    html = requests.get('https://atlas.herzen.spb.ru/faculty.php').text # получение исходного кода страницы

    bs = BeautifulSoup(html, 'html.parser') # инициализация BeautifulSoup
    namesList = bs.find('ul', {'class': 'list'}) # ссылки указаны в списке на странице
    names = namesList.findAll('li', {'class': 'list'}, recursive=False) # получение ссылок
    # recursive=False - чтобы выбрать институты, без списка кафедр (содержится внутри списка институтов)

    inst_list = [] # список институтов
    
    for el in names: # перебор всех элементов списка
        name = el.find('a', {'class': 'alist'}) # поиск ссылок
        data = dict() # информация об институте
        for institute in institutes_list: # поиск информации об институте
            if institute['institute_name'].lower() == name.text:
                data = institute
                break
        if not data:
            continue

        data['dep_list'] = [] # список кафедр
        
        depsList = el.find('ul', {'class': 'list'}) # получение списка кафедр на странице
        for dept in depsList.findAll('li', {'class': 'list'}): # перебор списка кафедр
            dep = dept.find('a', {'class': 'alist'}) # получение ссылки на страницу кафедры
            dep_name = dep.text.strip() # удаление пробельных символов
            link = dep.get('href') # получение ссылки
            if link.startswith('faculty_opop.php'): # пропускаем ссылки "список ОПОП"
                continue

            info = get_department_head_info(link) # получение информации о зав.кафедры
            # добавление информации
            data['dep_list'].append({
                'dep_name': dep_name,
                'head_name': info['head_name'],
                'email': info['email']
            })

        inst_list.append(data) # добавление информации в список

    return inst_list


inst_list = get_institutes_list()
print(inst_list)

import json
inst_data = get_institutes_data(inst_list)
print(json.dumps(inst_data, indent=4, ensure_ascii=False))
