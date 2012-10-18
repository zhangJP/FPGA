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
            LOCAL_DBUS_WIDE                             =>      LOCAL_DB_BUS_WIDE,
            BaseAddress0Size                            =>      0,
            BaseAddress1Size                            =>      0,
            BaseAddress2Size                            =>      6,
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
