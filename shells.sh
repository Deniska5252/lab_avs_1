mkdir lab0
cd lab0

mkdir arcobaleno
mkdir claude_monet

mkdir claude_monet/kitchen
mkdir claude_monet/chef_office
mkdir claude_monet/tasting_room

mkdir arcobaleno/kitchen
mkdir arcobaleno/office
mkdir arcobaleno/archive

echo 'Утиная ножка от Виктора Баринова' > claude_monet/kitchen/old_menu
echo 'Луковый суп Claude Monet' >> claude_monet/kitchen/old_menu
echo 'Фирменный салат от шефа' >> claude_monet/kitchen/old_menu
echo 'Десерт Луи с карамелью' >> claude_monet/kitchen/old_menu

echo 'Подготовить утиную ножку' > claude_monet/kitchen/duck_recipe
echo 'Добавить овощи и соус от Баринова' >> claude_monet/kitchen/duck_recipe
echo 'Перед подачей проверить температуру' >> claude_monet/kitchen/duck_recipe

echo 'Не повторять блюда конкурентов' > claude_monet/chef_office/barinov_notes
echo 'Катю допустить к общей дегустации' >> claude_monet/chef_office/barinov_notes
echo 'Лёва записывает замечания шефа' >> claude_monet/chef_office/barinov_notes
echo 'Последнее решение принимает Баринов' >> claude_monet/chef_office/barinov_notes

echo 'Блюдо Баринова получило девять баллов' > claude_monet/tasting_room/tasting_scores
echo 'Паста Кати получила восемь баллов' >> claude_monet/tasting_room/tasting_scores
echo 'Десерт Луи получил десять баллов' >> claude_monet/tasting_room/tasting_scores

echo 'Лёва проверил порядок подачи блюд' > claude_monet/tasting_room/leva_comment
echo 'Меню обоих ресторанов готово к сравнению' >> claude_monet/tasting_room/leva_comment
echo 'Результаты переданы Виктору Петровичу' >> claude_monet/tasting_room/leva_comment

echo 'Домашняя паста от Елены Павловны' > arcobaleno/kitchen/italian_menu
echo 'Ризотто с белыми грибами' >> arcobaleno/kitchen/italian_menu
echo 'Итальянский рыбный суп' >> arcobaleno/kitchen/italian_menu
echo 'Десерт по рецепту Кати' >> arcobaleno/kitchen/italian_menu

echo 'Катя приготовила молекулярную закуску' > arcobaleno/kitchen/katya_recipe
echo 'Для блюда использованы знакомые продукты' >> arcobaleno/kitchen/katya_recipe
echo 'Елена Павловна одобрила новую подачу' >> arcobaleno/kitchen/katya_recipe

echo 'Елена Павловна встречает критика' > arcobaleno/office/elena_plan
echo 'Катя представляет новое блюдо' >> arcobaleno/office/elena_plan
echo 'Команда Arcobaleno готовит итальянское меню' >> arcobaleno/office/elena_plan

echo 'Критик похвалил пасту в прошлый визит' > arcobaleno/archive/review_archive
echo 'Гости отметили спокойную работу кухни' >> arcobaleno/archive/review_archive
echo 'Елена сохранила отзыв для нового меню' >> arcobaleno/archive/review_archive

echo 'Ресторанный критик посетит оба ресторана' > critic_visit
echo 'Сначала он зайдёт в Claude Monet' >> critic_visit
echo 'После этого отправится в Arcobaleno' >> critic_visit

chmod u=rwx,g=rx,o=rx claude_monet
chmod 750 claude_monet/kitchen
chmod 644 claude_monet/kitchen/old_menu
chmod u=rw,g=r,o= claude_monet/kitchen/duck_recipe
chmod 710 claude_monet/chef_office
chmod 600 claude_monet/chef_office/barinov_notes
chmod u=rwx,g=rwx,o= claude_monet/tasting_room
chmod 640 claude_monet/tasting_room/tasting_scores
chmod u=r,g=r,o= claude_monet/tasting_room/leva_comment

chmod 755 arcobaleno
chmod u=rwx,g=rx,o= arcobaleno/kitchen
chmod 644 arcobaleno/kitchen/italian_menu
chmod u=rw,g=r,o= arcobaleno/kitchen/katya_recipe
chmod 750 arcobaleno/office
chmod u=r,g=r,o= arcobaleno/office/elena_plan
chmod u=rwx,g=rx,o= arcobaleno/archive
chmod 640 arcobaleno/archive/review_archive

chmod u=rw,g=r,o=r critic_visit
cp arcobaleno/kitchen/katya_recipe claude_monet/kitchen/new_recipe
cp -R arcobaleno/archive claude_monet/chef_office/reviews_copy
ln -s ../kitchen/katya_recipe arcobaleno/office/chef_recipe
ln -s arcobaleno/kitchen rival_kitchen
ln critic_visit claude_monet/tasting_room/critic_copy
cat claude_monet/kitchen/old_menu arcobaleno/kitchen/italian_menu > claude_monet/tasting_room/menu_comparison
cat claude_monet/tasting_room/leva_comment >> critic_visit
mv claude_monet/chef_office/barinov_notes claude_monet/tasting_room/chef_verdict

ls -lR lab0 | grep '^-' | grep -v 'copy' | sort -k5,5nr | head -n 5
grep -rhiE 'баринов|катя' lab0/claude_monet lab0/arcobaleno | grep -vi 'десерт' | sort | head -n 6
grep -rl 'блюд' lab0/claude_monet/kitchen lab0/arcobaleno/kitchen | wc -l
tail -q -n 2 lab0/claude_monet/kitchen/*_menu lab0/arcobaleno/kitchen/*_menu | grep -iE 'десерт|суп' | sort -r
grep -vi 'десерт' lab0/claude_monet/tasting_room/menu_comparison | sort -r | head -n 4 | wc -w
ls -liR lab0 | grep -E '[0-9]+ -[^ ]+ 2' | sort -k1,1n
grep -rhiE 'гост|меню' lab0/claude_monet/chef_office/reviews_copy | grep -v 'Елена' | sort | wc -l

rm arcobaleno/kitchen/katya_recipe
rm arcobaleno/office/chef_recipe
rm rival_kitchen
rm critic_visit
rm claude_monet/tasting_room/critic_copy
rm arcobaleno/archive/review_archive
rmdir arcobaleno/archive
rm -r claude_monet/chef_office/reviews_copy



git add .
git commit -m "сделал"
git push
