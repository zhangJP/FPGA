-- * Copyright (C) 2012 by ZhangJiPing
-- * All rights reserved.
-- *
-- * @Author:ZhangJiPing
-- *
-- * This program is free software; you can redistribute it and/or
-- * modify it under the terms of the GNU General Public License as
-- * published by the Free Software Foundation; either version 2 of
-- * the License, or (at your option) any later version.
-- *
-- * This program is distributed in the hope that it will be useful,
-- * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- * GNU General Public License for more details.
-- *
-- * You should have received a copy of the GNU General Public License
-- * along with this program; if not, write to the Free Software
-- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
-- * MA 02111-1307 USA
-- *
-- * @History:
-- * ZhangJiPing <cn.zhangJP@gmail.com> 

library ieee;
use ieee.std_logic_1164.all;
entity pci_top is
    generic(
        LOCAL_DB_BUS_WIDE       : integer range 0 to 127        := 32                                           ;
        DEVICE_ID               : std_logic_vector(15 downto 0) := x"9054"                                      ;
        VENDOR_ID               : std_logic_vector(15 downto 0) := x"10b5"                                      ;
        CLASS_CODE              : std_logic_vector(15 downto 0) := x"0680"                                      ;
        REVISION_ID             : std_logic_vector(15 downto 0) := x"00ab"                                      ;
        SYS_DEVICE_ID           : std_logic_vector(15 downto 0) := x"9054"                                      ;
        SYS_VENDOR_ID           : std_logic_vector(15 downto 0) := x"10b5"                                      ;
        COMMAND                 : std_logic_vector(15 downto 0) := x"0117"                                      ;
        STATUS                  : std_logic_vector(15 downto 0) := x"0290"                                      ;

        BaseAddress0Size        : integer         := 10                                                         ;
        BaseAddress1Size        : integer         := 6                                                          ;
        BaseAddress2Size        : integer         := 23                                                         ;
        BaseAddress3Size        : integer         := 23                                                          ;
        BaseAddress4Size        : integer         := 11                                                          ;
        BaseAddress5Size        : integer         := 6                                                          ;
        Bar0SpaceType           : std_logic       := '0'                                                        ;
        Bar1SpaceType           : std_logic       := '1'                                                        ;
        Bar2SpaceType           : std_logic       := '0'                                                        ;
        Bar3SpaceType           : std_logic       := '0'                                                        ;
        Bar4SpaceType           : std_logic       := '0'                                                        ;
        Bar5SpaceType           : std_logic       := '0'

        );
    port (
        clk	                	: in            std_logic                                                       ;
        rstn	               	: in            std_logic                                                       ;
        idsel	               	: in            std_logic                                                       ;
        framen	               	: inout         std_logic                                                       ;
        irdyn	            	: in            std_logic                                                       ;
        devseln	            	: inout         std_logic                                                       ;
        trdyn	               	: inout         std_logic                                                       ;
        stopn	               	: inout         std_logic                                                       ;
        intan	               	: out           std_logic                                                       ;
        serrn	               	: out           std_logic                                                       ;
        cben	               	: in         std_logic_vector (3 downto 0)                                   ;
        par	                	: inout         std_logic                                                       ;
        perrn	               	: inout         std_logic                                                       ;
        req 					: out 	        std_logic                                                       ;
        gnt 	              	: in 			std_logic                                                   ;
        lock 					: out 			std_logic 														;
        bd_sel 					: out 			std_logic 														;
        enum 					: out 			std_logic 														;
        ad                    	: inout         std_logic_vector(31 downto 0)                                   ;
        local_cs              	: out           std_logic_vector(5 downto 0)                                    ;
        local_wr              	: out           std_logic                                                       ;
        local_rd              	: out           std_logic                                                       ;
        local_ab              	: out           std_logic_vector(31 downto 0)                                   ;
        local_rdb             	: in            std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0)                  ;
        local_wdb             	: out           std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0)                  ;
        local_req_dma         	: in            std_logic ;
		local_int 				: in 			std_logic        
        );
end pci_top;

architecture syn of pci_top is
    component pci_core
	generic (
            DEVICE_ID                           : std_logic_vector(15 downto 0)                                 ;
            VENDOR_ID                           : std_logic_vector(15 downto 0)                                 ;
            CLASS_CODE                          : std_logic_vector(15 downto 0)                                 ;
            SYS_DEVICE_ID                       : std_logic_vector(15 downto 0)                                 ;
            SYS_VENDOR_ID                       : std_logic_vector(15 downto 0)                                 ;
            REVISION_ID                         : std_logic_vector(15 downto 0)                                 ;
            COMMAND                             : std_logic_vector(15 downto 0)                                 ;
            STATUS                              : std_logic_vector(15 downto 0)                                 ;
            LOCAL_DBUS_WIDE                     : integer range 0 to 127                                        ;
            BaseAddress0Size                    : integer         := 16                                         ;
            BaseAddress1Size                    : integer         := 6                                          ;
            BaseAddress2Size                    : integer         := 21                                         ;
            BaseAddress3Size                    : integer         := 6                                          ;
            BaseAddress4Size                    : integer         := 6                                          ;
            BaseAddress5Size                    : integer         := 6                                          ;
            Bar0SpaceType                       : std_logic       := '0'                                        ;
            Bar1SpaceType                       : std_logic       := '1'                                        ;
            Bar2SpaceType                       : std_logic       := '0'                                        ;
            Bar3SpaceType                       : std_logic       := '0'                                        ;
            Bar4SpaceType                       : std_logic       := '0'                                        ;
            Bar5SpaceType                       : std_logic       := '0'
            );
	port (
            clk	                                : in            std_logic                                       ;
            rstn	                        	: in            std_logic                                       ;
            idsel	                        	: in            std_logic                                       ;
            framen	                        	: inout         std_logic                                       ;
            irdyn	                        	: in            std_logic                                       ;
            devseln	                        	: inout         std_logic                                       ;
            trdyn	                        	: inout         std_logic                                       ;
            stopn	                        	: inout         std_logic                                       ;
            intan	                        	: out           std_logic                                       ;
            serrn	                        	: out           std_logic                                       ;
            cben	                        	: in         std_logic_vector (3 downto 0)                   ;
            par	                                : inout         std_logic                                       ;
            perrn	                        	: inout         std_logic                                       ;
            req 								: out 	        std_logic                                       ;
            gnt 								: in 		std_logic                                       ;
	        lock 								: out 			std_logic 														;
    	    bd_sel 								: out 			std_logic 														;
	        enum 								: out 			std_logic 														;
            ad                                  : inout         std_logic_vector(31 downto 0)                   ;

            local_cs                            : out           std_logic_vector(5 downto 0)                    ;
            local_wr                            : out           std_logic                                       ;
            local_rd                            : out           std_logic                                       ;
            local_ab                            : out           std_logic_vector(31 downto 0)                   ;
            local_rdb                           : in            std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0)  := x"00000000";
            local_wdb                           : out           std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0)  ;
            local_req_dma                       : in            std_logic										;
			local_int 							: in 			std_logic        
            );

    end component;

begin

    pci_t_32 : pci_core
	generic map (
            DEVICE_ID                                   => DEVICE_ID                                            ,
            VENDOR_ID                                   => VENDOR_ID                                            ,
            CLASS_CODE                                  => CLASS_CODE                                           ,
            SYS_DEVICE_ID                               => SYS_DEVICE_ID                                        ,
            SYS_VENDOR_ID                               => SYS_VENDOR_ID                                        ,
            REVISION_ID                                 => REVISION_ID                                          ,
            COMMAND                                     => COMMAND                                              ,
            STATUS                                      => STATUS                                               ,
            LOCAL_DBUS_WIDE                             => LOCAL_DB_BUS_WIDE                                    ,
            BaseAddress0Size                            => BaseAddress0Size                                     ,
            BaseAddress1Size                            => BaseAddress1Size                                     ,
            BaseAddress2Size                            => BaseAddress2Size                                     ,
            BaseAddress3Size                            => BaseAddress3Size                                     ,
            BaseAddress4Size                            => BaseAddress4Size                                     ,     
            BaseAddress5Size                            => BaseAddress5Size                                     ,
            Bar0SpaceType                               => Bar0SpaceType                                                  ,
            Bar1SpaceType                               => Bar1SpaceType                                                  ,
            Bar2SpaceType                               => Bar2SpaceType                                                  ,
            Bar3SpaceType                               => Bar3SpaceType                                                  ,
            Bar4SpaceType                               => Bar4SpaceType                                                  ,
            Bar5SpaceType                               => Bar5SpaceType
            )
	port map (
            clk                                         => clk                                                  ,
            rstn                                        => rstn                                                 ,
            idsel                                       => idsel                                                ,
            intan                                       => intan                                                ,
            serrn                                       => serrn                                                ,
            cben                                        => cben                                                 ,
            par                                         => par                                                  ,
            perrn                                       => perrn                                                ,
            framen                                      => framen                                               ,
            irdyn                                       => irdyn                                                ,
            devseln                                     => devseln                                              ,
            trdyn                                       => trdyn                                                ,
            stopn                                       => stopn                                                ,
            req 										=> req                                                  ,
            gnt 										=> gnt                                                  ,
            lock 										=> lock 												,
	        bd_sel 				   						=> bd_sel 												,
    	    enum 										=> enum 												,
            ad                                          => ad                                                   ,
                
            local_cs                                    => local_cs                                             ,
            local_wr                                    => local_wr                                             ,
            local_rd                                    => local_rd                                             ,
            local_ab                                    => local_ab                                             ,
            local_wdb(31 downto 0)     					=> local_wdb(31 downto 0)              					,
            local_rdb(31 downto 0)     					=> local_rdb(31 downto 0)              					,
            local_req_dma                               => local_req_dma										,
            local_int 									=> local_int
            );
end syn;
