#!/bin/bash

exec > "$HOME/.finance/weekly_reports/$(date +"%d-%m-%y")_report" 2>&1

echo "Gastos de la semana:"
echo "------------------------"
hledger bal expenses -b '1 weeks ago' -S
echo "------------------------"

# Money spent in the month since the salary payment
if [ "$(date +'%d')" -lt 13 ]; then
    start_date=$(date -v-1m -v13d +'%Y-%m-%d')
else
    start_date=$(date -v13d +'%Y-%m-%d')
fi
end_date=$(date +'%Y-%m-%d')

month_bal=$(hledger bal -b "$start_date" -e "$end_date" expenses | tail -1)
echo "Dinero gastado durante el mes: $month_bal"

echo "Biggest expenses:"
echo "------------------------"
hledger bal expenses -b '1 weeks ago' --depth 2 -S --no-total | head -5
echo "------------------------"
