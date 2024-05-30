
SELECT 
    c.periodId,
    c.institutionId,
    c.reportedCurrencyISOCode,
    c.tcPrimarySectorId AS companyPrimarySectorId,
    c.fiscalYear AS companyFiscalYear,
    c.periodEndDate AS companyPeriodEndDate,
    s.sectorPeriodId,
    s.tcPrimarySectorId AS sectorPrimarySectorId,
    s.tcSectorId,
    s.fiscalYear AS sectorFiscalYear,
    s.periodEndDate AS sectorPeriodEndDate,
    di.dataItemId,
    di.dataItemName,
    di.dataItemDefinition,
    di.magnitude,
    di.isText,
    e.tcEnvType,
    pd.dataItemValue AS companyDataItemValue,
    ptd.dataItemValueText AS companyDataItemValueText,
    spd.dataItemValue AS sectorDataItemValue,
    sptd.dataItemValueText AS sectorDataItemValueText
FROM 
    tcPeriod c
    LEFT JOIN tcPeriodData pd ON c.periodId = pd.periodId
    LEFT JOIN tcPeriodTextData ptd ON c.periodId = ptd.periodId
    LEFT JOIN tcSectorPeriod s ON c.institutionId = s.institutionId 
        AND c.reportedCurrencyISOCode = s.reportedCurrencyISOCode 
        AND c.tcPrimarySectorId = s.tcPrimarySectorId
        AND c.fiscalYear = s.fiscalYear
        AND c.periodEndDate = s.periodEndDate
    LEFT JOIN tcSectorPeriodData spd ON s.sectorPeriodId = spd.sectorPeriodId
    LEFT JOIN tcSectorPeriodTextData sptd ON s.sectorPeriodId = sptd.sectorPeriodId
    LEFT JOIN tcDataItem di ON pd.dataItemId = di.dataItemId OR ptd.dataItemId = di.dataItemId
        OR spd.dataItemId = di.dataItemId OR sptd.dataItemId = di.dataItemId
    LEFT JOIN tcDataItemToEnvType dite ON di.dataItemId = dite.dataItemId
    LEFT JOIN tcEnvType e ON dite.tcEnvTypeId = e.tcEnvTypeId
    LEFT JOIN tcSector sec ON s.tcSectorId = sec.tcSectorId;

