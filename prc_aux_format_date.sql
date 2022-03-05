set term ^ ;

/*! \fn aux_format_date
    \brief преобразует дату и время \a datetime в строку \a datestr according to specified format \a format
    \param datetime source date and time
    \param format target format
    \param[out] string text as result

    Format string is case sensitive and supports follow literals:
        - `d` or `dd` - day (`1` or `01`)
        - `M` or `MM` - month (`1` or `01`)
        - `yy` or `yyyy` - yeat (`22` or `2022`)
        - `h` or `hh` - hour (`1` or `01`)
        - `m` or `mm` - minute (`1` or `01`)
        - `s` or `ss` - second (`1` or `01`)
*/

create or alter procedure aux_format_date(
    datetime timestamp,
    format varchar(255) = ''
)
returns(
    string varchar(255)
)
as
declare val integer;
begin
    if (format containing 'd') then
    begin
        val = extract(day from datetime);
        format = replace(format, 'dd', lpad(val, 2, '0'));
        format = replace(format, 'd', val);
    end

    if (format containing 'M') then
    begin
        val = extract(month from datetime);
        format = replace(format, 'MM', lpad(val, 2, '0'));
        format = replace(format, 'M', val);
    end

    if (format containing 'y') then
    begin
        val = extract(year from datetime);
        format = replace(format, 'yyyy', val);
        format = replace(format, 'yy', right(val, 2));
    end

    if (format containing 'h') then
    begin
        val = extract(hour from datetime);
        format = replace(format, 'hh', lpad(val, 2, '0'));
        format = replace(format, 'h', val);
    end

    if (format containing 'm') then
    begin
        val = extract(minute from datetime);
        format = replace(format, 'mm', lpad(val, 2, '0'));
        format = replace(format, 'm', val);
    end

    if (format containing 's') then
    begin
        val = extract(second from datetime);
        format = replace(format, 'ss', lpad(val, 2, '0'));
        format = replace(format, 's', val);
    end

    string = format;
    suspend;
end^

set term ; ^

comment on parameter aux_format_date.format is 'Format string is case sensitive and supports follow literals:
- `d` or `dd` - day (`1` or `01`)
- `M` or `MM` - month (`1` or `01`)
- `yy` or `yyyy` - yeat (`22` or `2022`)
- `h` or `hh` - hour (`1` or `01`)
- `m` or `mm` - minute (`1` or `01`)
- `s` or `ss` - second (`1` or `01`)';