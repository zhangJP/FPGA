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
        LOCAL_DB_BUS_WIDE       :       integer         := 32
        );
    port (
        clk	                : in            std_logic;
        rstn	                : in            std_logic;
        idsel	                : in            std_logic;
        framen	                : inout         std_logic;
        irdyn	                : in            std_logic;
        devseln	                : inout         std_logic;
        trdyn	                : inout         std_logic;
        stopn	                : inout         std_logic;
        intan	                : out           std_logic;
        serrn	                : out           std_logic;
        cben	                : inout         std_logic_vector (3 downto 0);
        par	                : inout         std_logic;
        perrn	                : inout         std_logic;
        ad                      : inout         std_logic_vector(31 downto 0);

        local_wr                : out           std_logic;
        local_rd                : out           std_logic;
        local_ab                : out           std_logic_vector(31 downto 0);
        local_rdb               : in            std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0);
        local_wdb               : out           std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0)
        );
end pci_top;

architecture syn of pci_top is
    component pci_core
	generic (
            DEVICE_ID           : std_logic_vector(15 downto 0);
            LOCAL_DBUS_WIDE     : integer range 0 to 127;
            BaseAddress0Size    : integer         := 8     ;
            BaseAddress1Size    : integer         := 5     ;
            BaseAddress2Size    : integer         := 8     ;
            BaseAddress3Size    : integer         := 0     ;
            BaseAddress4Size    : integer         := 8     ;
            BaseAddress5Size    : integer         := 0     ;
            Bar2SpaceType       : std_logic       := '0'   ;
            Bar3SpaceType       : std_logic       := '0'   ;
            Bar4SpaceType       : std_logic       := '0'   ;
            Bar5SpaceType       : std_logic       := '0'
            );
	port (
            clk	                : in            std_logic;
            rstn	        : in            std_logic;
            idsel	        : in            std_logic;
            framen	        : inout         std_logic;
            irdyn	        : in            std_logic;
            devseln	        : inout         std_logic;
            trdyn	        : inout         std_logic;
            stopn	        : inout         std_logic;
            intan	        : out           std_logic;
            serrn	        : out           std_logic;
            cben	        : inout         std_logic_vector (3 downto 0);
            par	                : inout         std_logic;
            perrn	        : inout         std_logic;
            ad                  : inout         std_logic_vector(31 downto 0);

            local_wr            : out           std_logic;
            local_rd            : out           std_logic;
            local_ab            : out           std_logic_vector(31 downto 0);
            local_rdb           : in            std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0);
            local_wdb           : out           std_logic_vector(LOCAL_DB_BUS_WIDE-1 downto 0)
            );

    end component;

begin

    pci_t_32 : pci_core
	generic map (
            DEVICE_ID                                   =>      x"9054",
            LOCAL_DBUS_WIDE                             =>      LOCAL_DB_BUS_WIDE,
            BaseAddress0Size                            =>      0,
            BaseAddress1Size                            =>      0,
            BaseAddress2Size                            =>      8,
            BaseAddress3Size                            =>      6,
            BaseAddress4Size                            =>      6,
            BaseAddress5Size                            =>      6,
            Bar2SpaceType                               =>      '0',
            Bar3SpaceType                               =>      '0',
            Bar4SpaceType                               =>      '0',
            Bar5SpaceType                               =>      '0'
            )
	port map (
            clk                                         =>      clk,
            rstn                                        =>      rstn,
            idsel                                       =>      idsel,
            intan                                       =>      intan,
            serrn                                       =>      serrn,
            cben                                        =>      cben,
            par                                         =>      par,
            perrn                                       =>      perrn,
            framen                                      =>      framen,
            irdyn                                       =>      irdyn,
            devseln                                     =>      devseln,
            trdyn                                       =>      trdyn,
            stopn                                       =>      stopn,
            ad                                          =>      ad,
                
            local_wr                                    =>      local_wr,
            local_rd                                    =>      local_rd,
            local_ab                                    =>      local_ab,
            local_wdb(LOCAL_DB_BUS_WIDE-1 downto 0)     =>      local_wdb(LOCAL_DB_BUS_WIDE-1 downto 0),
            local_rdb(LOCAL_DB_BUS_WIDE-1 downto 0)     =>      local_rdb(LOCAL_DB_BUS_WIDE-1 downto 0)
            );
end syn;
