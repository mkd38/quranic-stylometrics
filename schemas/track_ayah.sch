<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <!-- verify text contains the correct number of ayahs -->
    
    <pattern> 
        <rule context="ayah[1]">  <!--carve out exception for first ayah-->
            <assert test="number(@n) = 1"> first ayah must take @n eq 1</assert>
        </rule>
        <rule context="ayah">
            <assert test="number(@n) &gt; preceding-sibling::ayah[1]/number(@n)"> ayah number must be greater than previous ayah </assert>
        </rule>
    </pattern>
        
    
    
    
    
    
</schema>